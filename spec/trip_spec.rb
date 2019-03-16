require File.dirname(__FILE__) + '/../lib/driving_history_analyzer/trip'
require 'date'


describe DrivingHistoryAnalyzer::Trip do

	describe "#to_s" do

		it "should print all the attributes of the trip object" do 

			time_elapsed = 2220 
			start_time = Time.new(2018, 11, 16, 9, 3)
			end_time = Time.new(2018, 11, 16, 9, 40)
			miles_driven = 101
			driver_name = "Spongebob"

			trip = DrivingHistoryAnalyzer::Trip.new(start_time, end_time, miles_driven, driver_name)

			expect(trip.to_s).to eq(""+
				"Driver: Spongebob,\n"+
				"Start Time: 09:03,\n"+
				"End Time: 09:40,\n"+
				"Miles Driven: 101,\n"+
				"Time Elapsed: 2220.0"+
			"")

		end
	end
	
end
