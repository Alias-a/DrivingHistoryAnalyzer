require File.dirname(__FILE__) + '/../lib/driving_history_analyzer/parser'
require File.dirname(__FILE__) + '/../lib/driving_history_analyzer/driver'
require File.dirname(__FILE__) + '/../lib/driving_history_analyzer/trip'
require File.dirname(__FILE__) + '/../lib/driving_history_analyzer/accepted_commands'

describe DrivingHistoryAnalyzer::Parser do

	describe ".parse" do

		context "When the line is a line with the driver command it" do 


			it "should parse a correctly formated driver line correctly and return a driver" do 

				driver_name = "Spongebob"
				driver_line = "Driver #{driver_name}"

				driver = DrivingHistoryAnalyzer::Parser.parse(driver_line)

				expected_driver = DrivingHistoryAnalyzer::Driver.new(driver_name)
				expect(driver).to eq(expected_driver)

			end

			it "should return 0 when there are too many parts in the driver line" do 

				driver_name = "Spongebob"
				driver_line = "Driver #{driver_name} 338"

				driver = DrivingHistoryAnalyzer::Parser.parse(driver_line)

				puts(driver.to_s)
				expect(driver).to eq(0)

			end

			it "should return 0 when there are too few parts in the driver line" do 

				driver_name = "Spongebob"
				driver_line = "Driver #{driver_name} 338"

				driver = DrivingHistoryAnalyzer::Parser.parse(driver_line)

				puts(driver.to_s)
				expect(driver).to eq(0)

			end


			it "should return 0 if the driver name is over 50 characters long" do 

				driver_name = "Shanmugavadivelanioperaninosferatulinaniomachikowannasignissi"
				driver_line = "Driver #{driver_name}"

				driver = DrivingHistoryAnalyzer::Parser.parse(driver_line)

				expect(driver).to eq(0)

			end

		end

		context "When the line is a line with the trip command it" do

			it "should parse a correctly formated trip line correctly and return a trip" do 

				driver_name = "Spongebob"
				miles_driven = 42.0
				start_time = DateTime.strptime("12:01", "%R").to_time
				end_time = DateTime.strptime("13:06", "%R").to_time 
				trip_line = "Trip #{driver_name} #{start_time.strftime("%H:%M")}" + 
					    " #{end_time.strftime("%H:%M")} #{miles_driven}"

				trip = DrivingHistoryAnalyzer::Parser.parse(trip_line)

				expected_trip = DrivingHistoryAnalyzer::Trip.new(start_time, end_time, miles_driven, driver_name)
				expect(trip).to eq(expected_trip)

			end

			it "should return 0 when the driver's name is over 50 characters" do 

				driver_name = "Shanmugavadivelanioperaninosferatulinaniomachikowannasignissi"
				trip_line = "Trip #{driver_name} 1:01 1:30 54.2"

				trip = DrivingHistoryAnalyzer::Parser.parse(trip_line)

				expect(trip).to eq(0)

			end
			
			it "should return 0 when there are too many parts in the trip line" do 

				driver_name = "Spongebob"
				miles_driven = 42.0
				start_time = DateTime.strptime("12:01", "%R").to_time
				end_time = DateTime.strptime("13:06", "%R").to_time 
				trip_line = "Trip #{driver_name} #{start_time.strftime("%H:%M")}" + 
					    " #{end_time.strftime("%H:%M")} #{miles_driven} extra"

				trip = DrivingHistoryAnalyzer::Parser.parse(trip_line)

				expect(trip).to eq(0)

			end

			it "should return 0 when there are too few parts in the trip line" do 

				driver_name = "Spongebob"
				miles_driven = 42.0
				start_time = DateTime.strptime("12:01", "%R").to_time
				end_time = DateTime.strptime("13:06", "%R").to_time 
				trip_line = "Trip #{driver_name} #{start_time.strftime("%H:%M")}" + 
					    " #{end_time.strftime("%H:%M")}"

				trip = DrivingHistoryAnalyzer::Parser.parse(trip_line)

				expect(trip).to eq(0)

			end


			it "should return 0 when the start time is in non 24-hour format" do 

				driver_name = "Spongebob"
				trip_line = "Trip #{driver_name} 1:01 1:30 54.2"

				trip = DrivingHistoryAnalyzer::Parser.parse(trip_line)

				expect(trip).to eq(0)

			end


			it "should return 0 when the start time is not a time string" do 

				driver_name = "Spongebob"
				trip_line = "Trip #{driver_name} notATime 1:30 54.2"

				trip = DrivingHistoryAnalyzer::Parser.parse(trip_line)

				expect(trip).to eq(0)

			end

			it "should return 0 when the end time is in non 24-hour format" do 

				driver_name = "Spongebob"
				trip_line = "Trip #{driver_name} 12:01 1:30 54.2"

				trip = DrivingHistoryAnalyzer::Parser.parse(trip_line)

				expect(trip).to eq(0)

			end

			it "should return 0 when the end time is not a time string" do 

				driver_name = "Spongebob"
				trip_line = "Trip #{driver_name} 12:01 notATime 54.2"

				trip = DrivingHistoryAnalyzer::Parser.parse(trip_line)

				expect(trip).to eq(0)

			end

			it "should return 0 when the miles driven is not a number" do 

				driver_name = "Spongebob"
				trip_line = "Trip #{driver_name} 12:01 1:25 notANumber" 

				trip = DrivingHistoryAnalyzer::Parser.parse(trip_line)

				expect(trip).to eq(0)

			end

		end

		it "should return 0 when the command is unsupported" do 

			driver_name = "Spongebob"
			line = "ImmmmmReady #{driver_name}"

			result = DrivingHistoryAnalyzer::Parser.parse(line)

			expect(result).to eq(0)

		end

	end
	
end
