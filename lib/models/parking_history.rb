require_relative '../config/database'

class ParkingHistory < ActiveRecord::Base

  belongs_to :vehicle
  belongs_to :parking_lot

end
