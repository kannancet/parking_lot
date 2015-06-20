=begin
  Test to Parking Lot and main functionality
=end
require "spec_helper"
describe ParkingLot do


	it "Should create parking lots" do
		ParkingLot.clean
		before_count = ParkingLot.count
		ParkingLot.create_parking_lot CREATE_PARKING_LOT_COMMAND

		after_count = ParkingLot.count
		expect(after_count-before_count).to eq 6
	end

	it "Should park 6 vehicles" do
		PARK_VEHICLE_COMMANDS.each do |command|
			output = ParkingLot.park command
		  expect(output.include?(ALLOCATION_MSG)).to eq true
		end
	end

	it "Should leave 4rth vehicle" do
		output = ParkingLot.leave LEAVE_FOURTH_VEHICLE_COMMAND
		expect(output).to eq FOURTH_SLOT_FREE_MSG
		@fourth_slot = ParkingLot.find_by_slot_number(4)
		expect(@fourth_slot.vehicle).to eq nil
	end

	it "Should show status" do
		output = ParkingLot.status STATUS_COMMAND
		expect(output.class).to eq Terminal::Table
	end


	it "Should park vehicle again" do
		output = ParkingLot.park PARK_AGAIN_COMMAND
		expect(output.include?(ALLOCATION_MSG)).to eq true
	end

	it 'Should show parking lot is full' do
    output = ParkingLot.park(PARKING_FULL_COMMAND)
		expect(output.include?(PARKING_LOT_FULL_MSG)).to eq true		
	end

	it 'Should give registration numbers for color' do
    output = ParkingLot.registration_numbers_for_cars_with_colour(REG_NOS_FOR_COLOR_COMMAND)
		expect(output).to eq COLOR_TO_REGNO_TEST_OUTPUT
	end

	it 'Should give slot numbers for color' do
    output = ParkingLot.slot_numbers_for_cars_with_colour(SLOT_NO_FOR_COLOR_COMMAND)
		expect(output).to eq COLOR_TO_SLOT_TEST_OUTPUT
	end

	it 'Should give slot numbers for registration no.' do
    output = ParkingLot.slot_number_for_registration_number(SLOT_NO_FOR_REG_COMMAND)
		expect(output).to eq 6
	end

	it 'Should give slot numbers for registration no.' do
    output = ParkingLot.slot_number_for_registration_number(SLOT_NO_FOR_REG_FAIL_COMMAND)
		expect(output).to eq "Not found"
	end

end