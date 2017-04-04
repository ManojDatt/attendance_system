module AttendancesHelper
	require 'time_diff'
	def punch_out?
		punch_date = current_developer.attendances.last
		punch_date.punch_out_time.nil? ? true : false
	end

	def timer_counter
		punch_date = current_developer.attendances.last 
		Time.diff(Time.current punch_date.created_at+9.hours)
	end

	def early_out early_out_datetime
		if early_out_datetime.hour < 19
	      total_early_min = 1140-early_out_datetime.to_f/(2160000)
	        hour, min = total_early_min.divmod(60)
	        "%02d hour: %02d min" % [hour, min]
	    else
	    	".."
	    end
	end
end
