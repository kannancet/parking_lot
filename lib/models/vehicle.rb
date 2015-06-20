require_relative '../config/database'
class Vehicle < ActiveRecord::Base
	
  belongs_to :parking_lot
  default_scope { where(vehicle_type: 'car') }


  #Function to leave vehicle if already parked
  def is_already_parked?
  	!parking_lot.blank?
  end

  #Function to park a vehicle in a free lot
  def park parking_lot
  	update(parking_lot_id: parking_lot.id) 
  	log_parking_history_in
  	parking_lot.make_busy

  	parking_lot.slot_number
  end

  #Function to create parking history
  def log_parking_history_in
  	parking_lot.parking_histories.create(checkin_time: Time.now, vehicle_id: id)
  end

  #Function to create parking history
  def log_parking_history_out
  	@history = ParkingHistory.where(vehicle_id: id, checkout_time: nil, parking_lot_id: parking_lot.id)
  													 .where.not(checkin_time: nil)
  												   .first
    @history.update(checkout_time: Time.now)
  end

  #Function to leave vehicle form parking lot
  def leave 
  	log_parking_history_out
  	slot_number = parking_lot.slot_number

		parking_lot.make_free
  	update(parking_lot_id: nil) 

  	slot_number
  end

  #Function to find registration_numbers_for_cars_with_colour White
  def self.registration_numbers_for_cars_with_colour color
  	@vehicles = joins(:parking_lot).where("parking_lots.state = ? AND vehicles.color = ?", "busy", color)
  	@vehicles.collect(&:registration_number)
  end

end