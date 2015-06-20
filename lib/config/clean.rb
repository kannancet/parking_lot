require_relative "../dependencies"
ActiveRecord::Schema.define do
  drop_table :parking_lots
  drop_table :vehicles
  drop_table :parking_histories
end
p "Destroyed all tables"
