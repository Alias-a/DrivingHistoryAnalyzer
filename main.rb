require File.dirname(__FILE__) + '/lib/driving_history_analyzer'

if __FILE__ == $0

	lines = ARGF.readlines
	DrivingHistoryAnalyzer.analyze(lines)

end
