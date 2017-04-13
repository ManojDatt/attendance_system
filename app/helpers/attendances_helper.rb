module AttendancesHelper
	require 'time_diff'
	def punch_out?

		if current_developer.attendances.exists?
			punch_date = current_developer.attendances.last.punch_out_status
			punch_date ? false : true
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




#######  These need to be run on background process and calculate first_half & second_half


	def first_period(attendance)
		# binding.pry
		##   If User punch-in before 10 AM
		if (attendance.punch_in_time.present?) and (attendance.punch_in_time.hour <= 10)
			if (Time.current >= (attendance.punch_in_time.hour + 4.hours))
				"PR"
			else
				".."
			end
		##   If User punch in after 10 AM	
		elsif (attendance.punch_in_time.present? and attendance.punch_in_time.hour > 10)
			"AB"
		else
		###   If attendance date is less then current date and some have week offs	 
			 if (attendance.created_at.to_date < Date.current) and (not attendance.week_off)
			 	"AB"
			 elsif attendance.week_off
			 	"WO"
			 elsif (attendance.created_at.to_date == Date.current) and (not attendance.week_off)
			 	if Time.current.hour > 10
			 		"AB"
			 	else
			 		".."
			 	end
			 else
			 	".."
			 end

		end 	

	end

	def second_period(attendance)
		##   If developer punch in within 2 PM
		if (attendance.punch_in_time.present?) and (attendance.punch_in_time.hour == 14)
			if (Time.current >= (attendance.punch_in_time.hour + 5.hours))
				"PR"
			else
				".."
			end
		##   If User punch in before 2 PM then check 2nd half after 7 PM
		elsif (attendance.punch_in_time.present?) and (attendance.punch_in_time.hour < 14)
			if attendance.punch_out_time.present? 
				if attendance.punch_out_time.hour > 19
					"PR"
				elsif 
					".."
				end
			end
		##   If User punch in after 2 PM then 2nd half will be AB	
		elsif (attendance.punch_in_time.present?) and (attendance.punch_in_time.hour > 15) 
			##  If User completes 4 hours then he will be PR in second half
			if (Date.current >= (attendance.punch_in_time + 4.hour))
				"PR"
			else
				if attendance.punch_out_time.present? and attendance.punch_out_time.hour < 4 
					"AB"
				else
					".."
				end

			end				
		
		else
			 ##   Date that is less then current date and some have week offs
			 if (attendance.created_at.to_date < Date.current) and (not attendance.week_off)
			 	"AB"
			 elsif attendance.week_off
			 	"WO"
			 elsif (attendance.created_at.to_date == Date.current) and (not attendance.week_off)
			 	if Time.current.hour > 10
			 		"AB"
			 	else
			 		".."
			 	end
			 else
			 	".."
			 end

		end 			
	end	
end










  
