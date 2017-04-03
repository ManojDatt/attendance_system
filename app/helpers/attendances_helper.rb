module AttendancesHelper
	require 'time_diff'
	def punch_out?
		punch_date = current_developer.attendances.last
		punch_date.punch_out_time.nil? ? true : false
	end

	def timer_counter
		punch_date = current_developer.attendances.last 
		Time.diff(Time.zone.now, punch_date.created_at+9.hours)
	end
end
