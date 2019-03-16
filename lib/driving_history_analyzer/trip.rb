module DrivingHistoryAnalyzer

	class Trip

		attr_reader :start_time, :end_time, :miles_driven, :time_elapsed, :driver_name

		def initialize(start_time, end_time, miles_driven, driver_name)

			@start_time = start_time
			@end_time = end_time
			@miles_driven = miles_driven
			@time_elapsed = end_time - start_time
			@driver_name = driver_name

		end	

		def ==(other_trip)
			
			equal = self.start_time == other_trip.start_time
			equal = equal && (self.end_time == other_trip.end_time)
			equal = equal && (self.miles_driven == other_trip.miles_driven)
			equal = equal && (self.time_elapsed == other_trip.time_elapsed)
			equal = equal && (self.driver_name == other_trip.driver_name)
			equal
			
		end

		def to_s

			""+
				"Driver: #{@driver_name},\n"+
				"Start Time: #{@start_time.strftime("%H:%M")},\n"+
				"End Time: #{@end_time.strftime("%H:%M")},\n"+
				"Miles Driven: #{@miles_driven},\n"+
				"Time Elapsed: #{@time_elapsed}"+
			""
		end

	end

end
