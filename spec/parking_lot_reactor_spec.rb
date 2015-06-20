=begin
  Test to desribe Main spec
=end
require "spec_helper"

describe ParkingLotBase do 

  before do
    ParkingLot.clean
  end

  it "Should give welcome message" do
    welcome_message = ParkingLotBase.give_welcome
    expect(welcome_message.class).to eq Terminal::Table
  end

  it "Should check the mode" do
    output = ParkingLotBase.is_file_mode? 
    expect(output).to eq false

    output = ParkingLotBase.is_file_mode? INPUT_FORMAT_FILE_MODE
    expect(output).to eq true
  end

  it "Should check if valid input" do
    output = ParkingLotBase.valid_input? INPUT_FORMAT_FILE_MODE
    expect(output).to eq true
  end

  it "Should initiate file mode" do
    count_before = ParkingLot.count
    output = ParkingLotBase.init_file_mode INPUT_FORMAT_FILE_MODE
    count_after = ParkingLot.count
    expect(count_after - count_before).to eq 6
  end

  it "Should print basic info" do
    output = ParkingLotBase.print_basic_info
    expect(output.class).to eq Array
  end

  it "Should print basic info" do
    output = ParkingLotBase.print_basic_info
    expect(output.class).to eq Array
  end

  it "Should clean output file" do
    ParkingLotBase.clean_output_file
    expect(File.zero?(OUTPUT_FILE)).to eq true
  end

end