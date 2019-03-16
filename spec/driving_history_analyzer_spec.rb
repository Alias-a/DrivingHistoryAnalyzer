require File.dirname(__FILE__) + '/../lib/driving_history_analyzer'

describe DrivingHistoryAnalyzer do

	describe ".analyze" do
	
		it "should return 1 and pring the driving history in descending order of miles driven when given proper input" do

			input_lines = [
				"Driver Dan\n",
				"Driver Alex\n",
				"Driver Bob\n",
				"Trip Dan 07:15 07:45 17.3\n",
				"Trip Dan 06:12 06:32 21.8\n",
				"Trip Alex 12:01 13:16 42.0\n"
			] 

			expected_output = "Alex: 42 miles @ 34 mph\n" +
					"Dan: 39 miles @ 47 mph\n" +
					"Bob: 0 miles @ 0 mph\n"

			output = DrivingHistoryAnalyzer.analyze(input_lines)

			expect {DrivingHistoryAnalyzer.analyze(input_lines)}.to output(expected_output).to_stdout
			expect(output).to eq(1)

		end

		it "should return -1 when given a trip command for a driver that is unregistered" do

			input_lines = [
				"Trip Dan 07:15 07:45 17.3\n",
				"Driver Dan\n",
				"Driver Alex\n",
				"Driver Bob\n",
				"Trip Dan 06:12 06:32 21.8\n",
				"Trip Alex 12:01 13:16 42.0\n"
			] 

			output = DrivingHistoryAnalyzer.analyze(input_lines)

			expect(output).to eq(-1)

		end

	end

end
