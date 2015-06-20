=begin
  Test to Vehicle and sub functionality
=end
require "spec_helper"
describe Vehicle do

	before do
		ParkingLot.clean
		@vehicle = Vehicle.find_or_create_by(registration_number: "KA-01-HH-1234", color: "White")
		@parking_lot = ParkingLot.find_or_create_by(slot_number: 100)
	end

	it "Should park a vehicle" do
		expect { @vehicle.park(@parking_lot) }.to change { @vehicle.parking_lot }.from(nil).to(@parking_lot)
	end

	it "Should check if vehicle already parked" do
		@vehicle.park(@parking_lot)
		expect(@vehicle.is_already_parked?).to eq true
	end

	it "Should log parking history in" do
		@vehicle.park(@parking_lot)
		history = @vehicle.parking_lot.parking_histories[0]
		expect(history.checkin_time).not_to eq nil
		expect(history.checkout_time).to eq nil
	end

	it "Should leave a vehicle from parking lot" do
		@vehicle.park(@parking_lot)
		lot = @vehicle.parking_lot 
		expect { @vehicle.leave }.to change { @vehicle.parking_lot }.from(lot).to(nil)
	end	

	it "Should log parking history out" do
		@vehicle.park(@parking_lot)
		@vehicle.leave
		history = ParkingHistory.where(vehicle_id: @vehicle.id, parking_lot_id: @parking_lot.id).first
		expect(history.checkin_time).not_to eq nil
		expect(history.checkout_time).not_to eq nil
		@vehicle.destroy
		@parking_lot.destroy
	end

end