module DrivingHistoryAnalyzer

	require File.dirname(__FILE__) + '/driving_history_analyzer/driver'
	require File.dirname(__FILE__) + '/driving_history_analyzer/trip'
	require File.dirname(__FILE__) + '/driving_history_analyzer/parser'
	require File.dirname(__FILE__) + '/driving_history_analyzer/accepted_commands'

	def DrivingHistoryAnalyzer.analyze(lines)

		drivers = Hash.new

		lines.each do |line|
			driver_or_trip = DrivingHistoryAnalyzer::Parser.parse(line)

			case driver_or_trip 
			when Driver
				driver = driver_or_trip
				drivers[driver.name] = driver
			when Trip
				trip = driver_or_trip

				unless drivers.has_key?(trip.driver_name)
					puts "The driver for this trip: \n #{trip.to_s} \n is unregistered."
					puts "Please check your input and try again"
					return -1
				end

				drivers[trip.driver_name].update_driving_history(trip)
			else
				puts "Something has gone wrong with the parser for this line: \n #{line}"
				return 0
			end
		end

		sorted_drivers = drivers.values.sort_by(&:total_miles_driven).reverse!
		sorted_drivers.each do |driver|
			puts driver.to_s
		end

		return 1
	end

end
