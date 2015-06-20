require 'active_record'
 
ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :dbfile  => ":memory:",
    :database => "parking_lot_ticketing"
)
 
ActiveRecord::Schema.define do

    create_table :parking_lots do |table|
        table.column :slot_number, :integer
        table.column :state, :string, default: 'free'

    end unless ActiveRecord::Base.connection.table_exists? 'parking_lots'
 
    create_table :vehicles do |table|
        table.column :registration_number, :string
        table.column :color, :string
        table.column :parking_lot_id, :integer
        table.column :vehicle_type, :string, default: 'car'
    end unless ActiveRecord::Base.connection.table_exists? 'vehicles'

    create_table :parking_histories do |table|
        table.column :checkin_time, :datetime
        table.column :checkout_time, :datetime
        table.column :parking_lot_id, :integer
        table.column :vehicle_id, :integer
    end unless ActiveRecord::Base.connection.table_exists? 'parking_histories'

end