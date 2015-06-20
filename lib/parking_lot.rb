require_relative "dependencies"

#Program starts here
begin
  ParkingLotBase.run
rescue Exception => e
  p e.message
end

 
