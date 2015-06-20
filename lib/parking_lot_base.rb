#Base class for logic
class ParkingLotBase

  class << self

    attr_accessor :command, :file


    #Function to print basic info
    def print_basic_info
      puts WELCOME_MSG
      rows = STATUS_HEADER
    end

    #Function to give welcome
    def give_welcome
      rows = print_basic_info
      SYSTEM_COMMANDS.collect{ |cmd| rows << [cmd[:command]]} 

      table = Terminal::Table.new :rows => rows
    end

    #Function to receive input
    def receive_input
      @command = STDIN.gets.strip
    end


    #Function to execute command
    def execute_command system_command_selected
      output = ParkingLot.send(system_command_selected.to_sym, @command)    
      output
    end

    #function to ask for inout again
    def print_output output
      puts output
    end

    #Function to select command
    def select_command
      selected_item = SYSTEM_COMMANDS.select{ |sys_command| @command.match(sys_command[:regex]) }[0]
      if selected_item
        selected_item[:command]
      else
        false
      end
    end

    #Function to check mode
    def is_file_mode?(input=nil)
      input ? input.include?(">") : false
    end

    #Function to create output file
    def create_output_file output
      File.open(OUTPUT_FILE, "a+") do |file|
        file.puts output
        file.puts "\n"
      end
    end

    #Truncate output file before write
    def clean_output_file
      file = File.open(OUTPUT_FILE, "a+")
      file.truncate(0)
    end

    #Function to check if file exist
    def file_exist?(input_file)
      @file = Dir["#{DATA_PATH}/#{input_file}"][0]
      !@file.nil?
    end

    #Function to execute each file line
    def execute_each_fileline 
      output = parse_input_command
      create_output_file output
      print_output output
    end

    #Function to parse input file
    def parse_file input_file
      File.open(@file, "r") do |file|

        while command = file.gets  
          unless command.blank?
            @command = command
            execute_each_fileline 
          end 
        end 
      end
    end

    #Function to parse input command
    def parse_input_command
      if system_command_selected = select_command
        output = execute_command system_command_selected
      else
        output = INVALID_MSG
      end

      output
    end

    #Function to initiate file mode
    def init_file_mode input
      input_file = input.split(">")[0].strip
      output_file = input.split(">")[1].strip

      if file_exist?(input_file)
        clean_output_file
        parse_file input_file
      else
        puts FILE_NOT_FOUND_MSG
      end
    end

    #Function to check if valid input
    def valid_input? input
    	matched = input.match FILE_INPUT_FORMAT

    	if matched
    		true
    	else
    		puts INVALID_INPUT_FORMAT_MSG
    		false
    	end
    end

    #Function to initiate user input mode
    def init_interactive_mode
      puts give_welcome

      while receive_input
        output = parse_input_command 
        print_output output
      end
    end

    #Function to start the program
    def run 
    	params = ARGV.first

      if is_file_mode? params	
        init_file_mode(params) if valid_input?(params)
      else
        init_interactive_mode
      end
    end

  end
end