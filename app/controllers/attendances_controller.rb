class AttendancesController < ApplicationController
  
  before_action :authenticate_developer!

  def index
    if current_developer.attendances.exists?
      punch_date = current_developer.attendances.last 
      unless punch_date.created_at.getlocal.strftime("%d-%m-%Y")==Time.zone.now.strftime("%d-%m-%Y")
        flash['success'] = "Punch In successfully"
        current_developer.attendances.create(punch_in_time: Time.zone.now)
      end
    else
      flash['success'] = "Punch In successfully"
      current_developer.attendances.create(punch_in_time: Time.zone.now)
    end
    @attendances = current_developer.attendances.page(params[:page]).per(3)

  end

  def create
    @attendance = current_developer.attendances.create(punch_in_time: Time.now)
    redirect_to attendances_url, notice:"Punch-In successfully."
  end

  def get_developer_profile
    @developer = current_developer
  end

  def punch_out
    @attendance = current_developer.attendances.last.update(punch_out_time: Time.now)
    redirect_to attendances_url, notice:"Punch-Out successfully."
  end

end
