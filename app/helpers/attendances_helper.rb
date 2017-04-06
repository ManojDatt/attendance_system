module AttendancesHelper
	require 'time_diff'
	def punch_out?
		punch_date = current_developer.attendances.last.punch_out_status
		punch_date ? false : punch_date
	end

	def timer_counter
		punch_date = current_developer.attendances.last 
		Time.diff(Time.current punch_date.created_at+9.hours)
	end

	def today_early_out(early_out_datetime)
		if early_out_datetime.hour < 19
	      total_early_min = 1140-(early_out_datetime.hour*60 + early_out_datetime.min)
	        hour, min = total_early_min.divmod(60)
	        p total_early_min.divmod(60)
	        "%02d hour: %02d min" % [hour, min]
	    else
	    	".."
	    end
	end

	CASE={"Monday"=>"#123",
		  "Tuesday"=>"#134",
		   "Wednesday"=>"#153",
		   "Thursday"=>"#173",
		   "Friday"=>"#120",
		   "Saturday"=>"#313",
		   "Sunday"=>"#100343",
		}
	def day_color(day)
		CASE[day]
	end
end
