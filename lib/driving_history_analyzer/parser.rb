module DrivingHistoryAnalyzer
	
	module Parser

		require 'date'
		require File.dirname(__FILE__) + '/accepted_commands'

		include DrivingHistoryAnalyzer::AcceptedCommands 

		@@time_regexp = /([0-1]\d|2[0-3]):[0-5]\d/
		@@parts = Hash.new

		# I include these here as aliases to avoid having to type out their long counterparts
		@@trip_command = DrivingHistoryAnalyzer::AcceptedCommands::TRIP
		@@driver_command = DrivingHistoryAnalyzer::AcceptedCommands::DRIVER

		def Parser.parse(line)

			if valid?(line) 

				driver_name = @@parts[:driver_name]

				case @@parts[:command] 
				when @@trip_command

					start_time = @@parts[:start_time]
					start_time = DateTime.strptime(start_time, "%R").to_time
					end_time = @@parts[:end_time] 
					end_time = DateTime.strptime(end_time, "%R").to_time
					return Trip.new(start_time, end_time, @@parts[:miles_driven].to_f, driver_name)

				when @@driver_command
					return Driver.new(driver_name)
				end

			end

			return 0
		end

		private

			def Parser.valid?(line)

				parts_arr = get_parts(line)

				# I know I could just as easily return all these conditions in large && expression
				# but I'm doing it this way for readability, I make all the subparts of this function
				# into their functions for the same reason as well as to make unit testing easier
				unless command_valid?(parts_arr) then return false end
				unless driver_name_valid?(@@parts[:driver_name]) then return false end

				if (@@parts[:command] == @@driver_command) then return true end

				unless time_valid?(@@parts[:start_time]) then return false end
				unless time_valid?(@@parts[:end_time]) then return false end
				unless miles_driven_valid?(@@parts[:miles_driven]) then return false end

				return true

			end

			def Parser.command_valid?(parts_arr)
				
				case @@parts[:command] 
				when @@trip_command
					return (parts_arr.length === 5) 
				when @@driver_command
					return (parts_arr.length === 2)
				else
					puts "This command: #{@@parts[:command]} is not an accepted command."
					return false
				end

			end

			def Parser.driver_name_valid?(name)

				# I'm limiting it to 50 characters because I don't want to have to deal with potential 
				# memory issues or the output for a driver overflowing a single line. 
				# I apologize to any Shanmugavadivelanioperaninosferatulinaniomachikowannasignissi out 
				# there. If this is you, please consult your creators.
				# This program does accept nicknames.

				name_valid = (name.length > 0 && name.length < 50)

				unless name_valid
					puts "The driver name is too long."
					puts "Please express my sympathy to this driver, their childhood must have been rough."
					puts "This program accepts nicknames."
				end
					
				name_valid	

			end

			def Parser.time_valid?(time)

				time_valid = time.match?(@@time_regexp)

				unless time_valid
					puts "This time: #{time} is invalid." 
					puts "All times must match a 24 Hour format in the form HH:MM"
				end

				time_valid

			end

			def Parser.miles_driven_valid?(miles_driven)

				# I'm trusting Ruby's String to_f method to handle validation in this case. 
				# It isn't the most considerate choice for the user as a string can potentially be too long
				# to fit into a float primitive representation, but frankly, if a user is attempting to put in
				# a number that long for miles they're either too stupid to be using this program or are being
				# deliberately malicious and I'm just too lazy at this point to develop a pretty regex to check
				# for that case.
				(miles_driven.to_f != (0.0))

			end
			
			def Parser.get_parts(line)
				
				parts_arr = line.split(/\s+/)

				@@parts[:command] = parts_arr[0]
				@@parts[:driver_name] = parts_arr[1]
				@@parts[:start_time] = parts_arr[2] 
				@@parts[:end_time] = parts_arr[3] 
				@@parts[:miles_driven] = parts_arr[4]
					
				parts_arr

			end

	end
end
