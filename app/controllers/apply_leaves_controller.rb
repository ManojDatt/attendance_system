class ApplyLeavesController < ApplicationController
	layout "developer_layout"
  before_action :authenticate_developer!
  def index
  	
  end
  def new
  	@apply_leave = ApplyLeave.new  	
  end

  def create
  	@apply_leave = current_developer.apply_leaves.new(params_apply_leave)
  	if @apply_leave.save
  		flash[:success]="Application submited success fully..."
  		redirect_to '/'
  	else
  		flash[:danger]="We are sorry, but something went wrong..."
  		redirect_to '/'
  	end	
  end
  private
  def params_apply_leave
    params[:apply_leave][:status] = "Pending"
  	params[:apply_leave][:total_leave]= (params[:apply_leave][:end_date].to_i-params[:apply_leave][:start_date].to_i)+1
  	params.require(:apply_leave).permit(:total_leave,:start_date,:end_date,:reason,:status)
  	
  end
end
