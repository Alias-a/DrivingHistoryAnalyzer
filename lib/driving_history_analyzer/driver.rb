module DrivingHistoryAnalyzer

	class Driver

		SECONDS_IN_AN_HOUR = 3600

		attr_accessor :name
		attr_reader :total_time_driven, :total_miles_driven, :average_mph

		def initialize(name)
			@name = name
			@total_time_driven = 0
			@total_miles_driven = 0
			@average_mph = 0
		end

		def update_driving_history(trip)

			@total_time_driven += trip.time_elapsed
			@total_miles_driven += trip.miles_driven
			average_mps = @total_miles_driven/@total_time_driven
			@average_mph = convert_mps_to_mph(average_mps)

		end

		def to_s
			"#{@name}: #{@total_miles_driven.round} miles @ #{@average_mph.round} mph"
		end

		def ==(other_driver)

			equal = self.name == other_driver.name
			equal = equal && (self.total_time_driven == other_driver.total_time_driven)
			equal = equal && (self.total_miles_driven == other_driver.total_miles_driven)
			equal = equal && (self.average_mph == other_driver.average_mph)
			equal

		end

		# TODO maybe this should go in a time helper module
		def convert_mps_to_mph(mps)
			mps * SECONDS_IN_AN_HOUR
		end


		private :convert_mps_to_mph
	end
end
