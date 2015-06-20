require_relative '../config/database'

class ParkingLot < ActiveRecord::Base

  has_one :vehicle, dependent: :destroy
  has_many :parking_histories, dependent: :destroy

  #Function to make parking lot busy
  def make_busy
  	update(state: "busy") 
  end

  #Function to make parking lot free
  def make_free
  	update(state: "free") 
  end

  #Function to get current vehicle data
  def current_vehicle_data
    slot, reg_number, color = slot_number, vehicle.registration_number, vehicle.color
  	[slot, reg_number, color]
  end

  #Function to get busy slots
  def self.busy_slots
  	joins(:vehicle).where(state: "busy").order("parking_lots.slot_number ASC")
  end

  #Funtion to bulk create parking lots
  def self.bulk_create count
  	ParkingLot.clean

    count.times do |number| 
      ParkingLot.create(slot_number: number+1)
    end 

    ParkingLot.count 	
  end

  #Function to get all vehicle dala
  def self.vehicles_parked_data
  	rows = []
    busy_slots.each do |parking_lot|
    	rows << parking_lot.current_vehicle_data
    end

    rows
  end

  #Function to build vehicle
  def self.build_vehicle(command)
  	data = command.split(" ")
   	number = data[1]
  	color = data[2]

  	Vehicle.find_or_create_by(registration_number: number, color: color)
  end

  #Function to execute park
  def self.execute_park free_lot
    if free_lot.blank?
      output = PARKING_LOT_FULL_MSG
    else
      slot_number = @vehicle.park free_lot
      output = "Allocated slot number: #{slot_number}"
    end

    output
  end

  #Function to exucute leave
  def self.execute_leave busy_lot
  	slot_number = busy_lot.vehicle.leave
    output = "Slot number #{slot_number} is free"

    output
  end

  #Function to print parking lot status
  def self.print_parking_lot_status rows
    output = Terminal::Table.new :rows => rows
    output
  end

  #Function to clean parking lots
  def self.clean
  	destroy_all
  end

=begin
	SYSTEM COMMAND METHODS GOES HERE.
	THIS IS INVOKED BY THE LIB CLASS ParkingLotReactor
=end

  #Execution of create_parking_lot command
  def self.create_parking_lot command 
    if count = command.split(" ")[1].to_i

      created_lot_count = bulk_create count
      output = "Created a parking lot with #{count} slots"
    else
    	output = "Invalid input. Please give integer number for parking lot count"
    end

    output
  end

  #Execution of park command
  def self.park(command)
  	@vehicle = build_vehicle(command)
  	if @vehicle.is_already_parked?
  		@vehicle.leave 
  		@vehicle = build_vehicle(command)
  	end

    free_lot = ParkingLot.where(state: "free")[0]
    output = execute_park(free_lot)

    output
  end

  #Execution of park command
  def self.leave(command)
  	slot_number = command.split(" ")[1]
  	busy_lot = ParkingLot.find_by_slot_number(slot_number)
    output = execute_leave(busy_lot)

    output
  end

  #Function to show status of parking lots
  def self.status(command = nil)
    rows = [
            ["Slot No.", "Registration No", "Colour"],
            ["--------","----------------", "-------"]
           ]
    rows  = rows + vehicles_parked_data
    output = print_parking_lot_status(rows)

    output
  end

  #Function to find registration_numbers_for_cars_with_colour 
  def self.registration_numbers_for_cars_with_colour command
  	color = command.split(" ")[1]
  	registration_numbers = Vehicle.registration_numbers_for_cars_with_colour color
  	output = registration_numbers.blank? ?  "Not found" : registration_numbers.join(",")
  	
  	output
  end

  #Function to find slot_numbers_for_cars_with_colour 
  def self.slot_numbers_for_cars_with_colour command
  	color = command.split(" ")[1]
  	parking_lots = joins(:vehicle).where("parking_lots.state = ? AND vehicles.color = ?", "busy", color)
  	output = parking_lots.collect(&:slot_number).join(",")
  	
  	output
  end

  #Function to find slot_number_for_registration_number
  def self.slot_number_for_registration_number command
  	reg_number = command.split(" ")[1]
  	parking_lot = joins(:vehicle).where("parking_lots.state = ? AND vehicles.registration_number = ?", "busy", reg_number).first
  	output = parking_lot ? parking_lot.slot_number : "Not found"
  	
  	output
  end

  #Function to exit 
  def self.exit command
  	puts "Bye ! Have a nice day."
  	Kernel.exit(false)
  end

end
