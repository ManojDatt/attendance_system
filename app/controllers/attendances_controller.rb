class AttendancesController < ApplicationController
  
  before_action :authenticate_developer!

  def index
     Time.now.hour > 9 ? lat_in=true : lat_in=false  
    if current_developer.attendances.exists?
      punch_date = current_developer.attendances.last 
      unless punch_date.created_at.getlocal.strftime("%d-%m-%Y")==Time.zone.now.strftime("%d-%m-%Y")
        flash['success'] = "Punch In successfully"           
        current_developer.attendances.create(punch_in_time: Time.zone.now, lat_in: lat_in)
      end
    else
      flash['success'] = "Punch In successfully"
      current_developer.attendances.create(punch_in_time: Time.zone.now, lat_in: lat_in)
    end
    @attendances = current_developer.attendances.page(params[:page]).per(3)

  end

  
  def get_developer_profile
    @developer = current_developer
  end

  def punch_out
    Time.now.hour > 19 ? lat_out=true : lat_out=false 
    @attendance = current_developer.attendances.last.update(punch_out_time: Time.now, lat_out:lat_out)
    redirect_to attendances_url, notice:"Punch-Out successfully."
  end

end
