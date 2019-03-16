require File.dirname(__FILE__) + '/../lib/driving_history_analyzer/driver'
require File.dirname(__FILE__) + '/../lib/driving_history_analyzer/trip'
require 'date'


describe DrivingHistoryAnalyzer::Driver do

	let (:driver) { DrivingHistoryAnalyzer::Driver.new(driver_name) }

	driver_name = "C3P0"
	driver = DrivingHistoryAnalyzer::Driver.new(driver_name)


	describe "#update_driving_history" do
	
		it "should update the driver's driving history correctly when given an appropriately formatted trip" do


			start_time = Time.now
			time_elapsed = 160000 
			end_time = start_time + time_elapsed 
			miles_driven = 100.05
			trip = DrivingHistoryAnalyzer::Trip.new(start_time, end_time, miles_driven, driver_name) 

			driver.update_driving_history(trip)

			expected_average_mph = 2.251125

			expect(driver.name).to eq(driver_name)
			expect(driver.total_time_driven).to eq(time_elapsed)
			expect(driver.total_miles_driven).to eq(miles_driven)
			expect(driver.average_mph).to eq(expected_average_mph)

		end

	end

	describe "#to_s" do

		it "should print the drivers name, the miles driven rounded to the nearest integer " +
		   "and the average mph rounded to the nearest integer" do

			expect(driver.to_s).to eq("C3P0: 100 miles @ 2 mph")

		end
	end

	
end
