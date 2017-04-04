class AttendancesController < ApplicationController
  layout "developer_layout"
  before_action :authenticate_developer!

  def index
     Time.current.hour > 10 and Time.current.min >0 ? lat_in=Time.current : lat_in=Time.current  
    if current_developer.attendances.exists?
      punch_date = current_developer.attendances.last 
      unless punch_date.created_at.getlocal.strftime("%d-%m-%Y")==Time.current.strftime("%d-%m-%Y")
        flash['success'] = "Punch In successfully"           
        current_developer.attendances.create(punch_in_time: Time.current, lat_in: lat_in)
      end
    else
      flash['success'] = "Punch In successfully"
      current_developer.attendances.create(punch_in_time: Time.current, lat_in: lat_in)
    end
    @attendances = current_developer.attendances.page(params[:page]).per(3)

  end

  
  def get_developer_profile
    @developer = current_developer
  end

  def punch_out
    total_work_min = (Time.current - current_developer.attendances.last.punch_in_time)/60
    hour, min = total_work_min.divmod(60)
    work_hour = "%02d hour: %02d min" % [hour, min]

    if Time.current.hour >= 19 and Time.current.min >0
      total_extra_min = early_out_datetime.to_f/(2160000) - 1140
      hour, min = total_extra_min.divmod(60)
      @extra_work = "%02d hour: %02d min" % [hour, min]
    end

    @attendance = current_developer.attendances.last.update(punch_out_time: Time.current, early_out:Time.current,work_hour: work_hour, extra_work:@extra_work)
    redirect_to attendances_url, notice:"Punch-Out successfully."
  end

end
