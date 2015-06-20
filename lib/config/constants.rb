#GENERAL CONSTANTS GOES HERE
SYSTEM_COMMANDS = [	
										{command: "create_parking_lot",
										 regex: /^create_parking_lot \d+$/
										 },
										{command: "park",
											regex: /^park \w+-\d+-\w+-\d+ \D+$/
										},
										{command: "leave",
										 regex: /^leave \d+$/
										},
										{command: "status",
										 regex: /^status$/
										},
										{command: "registration_numbers_for_cars_with_colour",
										 regex: /^registration_numbers_for_cars_with_colour \D+$/
										},
										{command: "slot_numbers_for_cars_with_colour",
										 regex: /^slot_numbers_for_cars_with_colour \D+$/
										},
										{command: "slot_number_for_registration_number",
										 regex: /^slot_number_for_registration_number \w{2}-\d{2}-\w{2}-\d{4}$/
										},
										{command: "exit",
										 regex: /^exit$/
										}
									]

FILE_INPUT_FORMAT = /^\w+.txt > \w+.txt$/

#RSPEC CONSTANTS GOES HERE
CREATE_PARKING_LOT_COMMAND = "create_parking_lot 6"
PARK_VEHICLE_COMMANDS =  [
													"park KA-01-HH-1234 White",
												  "park KA-01-HH-9999 White",
												  "park KA-01-BB-0001 Black",
												  "park KA-01-HH-7777 Red",
												  "park KA-01-HH-2701 Blue",
												  "park KA-01-HH-3141 Black"
												 ]
LEAVE_FOURTH_VEHICLE_COMMAND = "leave 4"
STATUS_COMMAND = "status"
PARK_AGAIN_COMMAND = "park KA-01-P-333 White"
PARKING_FULL_COMMAND = "park DL-12-AA-9999 White"
REG_NOS_FOR_COLOR_COMMAND = "registration_numbers_for_cars_with_colour White"
SLOT_NO_FOR_COLOR_COMMAND = "slot_numbers_for_cars_with_colour White"
SLOT_NO_FOR_REG_COMMAND = "slot_number_for_registration_number KA-01-HH-3141"
SLOT_NO_FOR_REG_FAIL_COMMAND = "slot_number_for_registration_number MH-04-AY-1111"
ALLOCATION_MSG = "Allocated slot number:"
COLOR_TO_REGNO_TEST_OUTPUT = "KA-01-HH-1234,KA-01-HH-9999,KA-01-P-333"
COLOR_TO_SLOT_TEST_OUTPUT = "1,2,4"
FOURTH_SLOT_FREE_MSG = "Slot number 4 is free"


#PROGRAM CONSTANTS GOES HERE
INPUT_FORMAT_FILE_MODE = 'file_inputs.txt > output.txt'
OUTPUT_FILE = "#{Dir.pwd}/lib/data/output.txt"
DATA_PATH = "#{Dir.pwd}/lib/data"

WELCOME_MSG = "Hi Buddy. WELCOME TO PRAKING LOT APPLICATION !"
STATUS_HEADER = [
		              ["AVAILABLE SYSTEM COMMANDS"],
		              ["-------------------------"]
		             ]
INVALID_MSG = "Invalid command. Please try again"
FILE_NOT_FOUND_MSG = "Input file not found. Please add your file to parking_lot/lib/data directory."
INVALID_INPUT_FORMAT_MSG = "Invalid input format. Expected type - 'file_inputs.txt > output.txt' "

PARKING_LOT_FULL_MSG = "Sorry, parking lot is full"
