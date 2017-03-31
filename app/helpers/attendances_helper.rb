module AttendancesHelper
	def punch_in?
		if current_developer.attendances.exists?
			punch_date = current_developer.attendances.last 
			unless punch_date.created_at.getlocal.strftime("%d-%m-%Y")==Time.now.strftime("%d-%m-%Y")
				current_developer.attendances.create(punch_in_time: Time.now)
			end
		else
			current_developer.attendances.create(punch_in_time: Time.now)
		end
		
	end
	def punch_out?
		punch_date = current_developer.attendances.last
		punch_date.punch_out_time.nil? ? true : false
		
	end
end
