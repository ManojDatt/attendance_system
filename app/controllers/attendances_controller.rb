class AttendancesController < ApplicationController
  before_action :authenticate_developer!

  def index
    @attendances = current_developer.attendances.page(params[:page]).per(3)
  end

  def create
    @attendance = current_developer.attendances.create(punch_in_time: Time.now)
    redirect_to attendances_url, notice:"Punch-In successfully."
  end

  def punch_out
    @attendance = current_developer.attendances.last.update(punch_out_time: Time.now)
    redirect_to attendances_url, notice:"Punch-Out successfully."
  end

end
