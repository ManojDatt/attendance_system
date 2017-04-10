class Attendance < ApplicationRecord
  belongs_to :developer
  default_scope {order("created_at::date")}
  def self.run_monthlly
      ###== This method will run on every month first day to create blank attendace for every developer
      developers = Developer.all 
      sunday = []
      saturday = []
      all_days = (DateTime.current.beginning_of_month..DateTime.current.end_of_month).to_a
      ##   select all sunday of the month and push in sunday array
      all_days.each_with_index{|v,i| sunday.append(i) if v.wday==0}
      ##   select all saturady of the month and push in saturday array
      all_days.each_with_index{|v,i| saturday.append(i) if v.wday==6}

    	  developers.each do |developer|
    	  	all_days.each_with_index do |day, index|
            day = day + 5.5.hours
    	  		if index == saturday[1] || index == saturday[3] || sunday.include?(index)
    	  			developer.attendances.create(week_off: true, created_at:day, updated_at:day)

    	  		elsif index == saturday[0] || index == saturday[2] || index == saturday[4]
    	  			developer.attendances.create(punch_in_at: 9.5, punch_out_at: 16,  created_at:day, updated_at:day)

    	  		else
    	  			developer.attendances.create( created_at:day, updated_at:day)
    	  		end
    	  	end
    	  end
    end

    def self.first_half
      developers = Developer.all.includes(:attendances)
      if developers.present?
        developers.each do |current_developer|
          current_developer.attendances.each do |attendance|
           if (attendance.punch_in_time.present?) and (attendance.punch_in_time.hour <= 10)
              if (Time.current >= (attendance.punch_in_time.hour + 4.hours))
                p "PR"
                attendance.update(first_half: true)
              else
                ".."
              end
            ##   If User punch in after 10 AM 
            elsif (attendance.punch_in_time.present? and attendance.punch_in_time.hour > 10)
              p "AB"
              attendance.update(first_half: false)
            else
            ###   If attendance date is less then current date and some have week offs   
               if (attendance.created_at.to_date < Date.current) and (not attendance.week_off)
                p "AB"
                attendance.update(first_half: false)
               elsif attendance.week_off
                "WO"
               elsif (attendance.created_at.to_date == Date.current) and (not attendance.week_off)
                  if Time.current.hour > 10
                    p "AB"
                    attendance.update(first_half: false)
                  else
                    ".."
                  end
               else
                ".."
               end

            end   
          end
        end
      end 
    end

    def self.second_half
      developers = Developer.all.includes(:attendances)
      if developers.present?
        developers.each do |current_developer|
          current_developer.attendances.each do |attendance|
           

            if (attendance.punch_in_time.present?) and (attendance.punch_in_time.hour == 14)
              if (Time.current >= (attendance.punch_in_time.hour + 5.hours))
                p "PR"
                attendance.update(first_half: true)
              else
                ".."
              end
            ##   If User punch in before 2 PM then check 2nd half after 7 PM
            elsif (attendance.punch_in_time.present?) and (attendance.punch_in_time.hour < 14)
              if attendance.punch_out_time.present? 
                if attendance.punch_out_time.hour > 19
                  p"PR"
                  attendance.update(first_half: true)
                elsif 
                  ".."
                end
              end
            ##   If User punch in after 2 PM then 2nd half will be AB 
            elsif (attendance.punch_in_time.present?) and (attendance.punch_in_time.hour > 15) 
              ##  If User completes 4 hours then he will be PR in second half
              if (Date.current >= (attendance.punch_in_time + 4.hour))
                p"PR"
                attendance.update(first_half: true)
              else
                if attendance.punch_out_time.present? and attendance.punch_out_time.hour < 4 
                  p "AB"
                  attendance.update(first_half: false)
                else
                  ".."
                end

              end       
            
            else
               ##   Date that is less then current date and some have week offs
               if (attendance.created_at.to_date < Date.current) and (not attendance.week_off)
                p"AB"
                attendance.update(first_half: false)
               elsif attendance.week_off
                "WO"
               elsif (attendance.created_at.to_date == Date.current) and (not attendance.week_off)
                if Time.current.hour > 10
                  p"AB"
                  attendance.update(first_half: false)
                else
                  ".."
                end
               else
                ".."
               end

            end       

          end
        end
      end      
    end

   


end
