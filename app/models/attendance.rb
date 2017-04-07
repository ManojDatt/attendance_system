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
end
