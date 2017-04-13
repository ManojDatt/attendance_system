class ApplyLeavesController < ApplicationController
	layout "developer_layout"
  before_action :authenticate_developer!
  before_filter :validate_leave_type,only:[:create]
  def index
    @apply_leaves = current_developer.apply_leaves.all.page(params[:page]).per(5)
  end
  def new
  	@apply_leave = ApplyLeave.new  	
  end

  def create      
  	@apply_leave = current_developer.apply_leaves.new(params_apply_leave)
  	if @apply_leave.save
      if params[:apply_leave][:leave_type] == "Paid"
        @total_available_leave= @avail_leave - @apply_leave.total_leave
        current_developer.leave.update(available_leave:@total_available_leave)
      end
      ActionCable.server.broadcast "admin:attendances", {message:"#{current_developer.email} apply leave", user:current_developer.name}
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
  	params[:apply_leave][:total_leave] = (params[:apply_leave][:end_date].to_i-params[:apply_leave][:start_date].to_i)+1
  	params.require(:apply_leave).permit(:total_leave,:start_date,:end_date,:reason,:status,:leave_type)
  	
  end

  def validate_leave_type 
    @avail_leave = current_developer.leave.available_leave
    if params[:apply_leave][:leave_type] == "Paid" && @avail_leave < (params[:apply_leave][:end_date].to_i-params[:apply_leave][:start_date].to_i)+1
      redirect_to leaves_path  flash[:danger]= "Sorry you don't have enough leave balance, apply with unpaid leave !"
    end    
  end
end

    
