class AttendancesController < ApplicationController
  layout "developer_layout"
  before_action :authenticate_developer!
  before_action :verrify_mac_address
  def index
     # binding.pry
     #s=Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
     #s.ip_address
     #Mac.addr
     p "========"+ Mac.addr
    if current_developer.attendances.exists?
      punch_date = current_developer.attendances.where("created_at::date=?",Date.current).first 
      unless punch_date.punch_in_status

          punch_in_time_min_total = (Time.current.hour*60)+Time.current.min
          punch_in_time_min_total > (punch_date.punch_in_at*60).to_i ? lat_in=(Time.current - punch_date.punch_in_at.hour) : lat_in=nil
            
            ActionCable.server.broadcast "dsr_channel", {message:"#{current_developer.name} has punch in on #{Time.current.strftime('%I:%M %p')}",user:current_developer.name}
            flash['success'] = "Punch In successfully"           
            punch_date.update(punch_in_time: Time.current, lat_in: lat_in, punch_in_status: true)
            message = "#{current_developer.name} has punch in at #{Time.current.strftime('%A %H:%M %p')}" 
            notification_type = 
            current_developer.notifications.create(message:message, notification_type:"")
          
       end
       # @attendances = current_developer.attendances.page(params[:page]).per(31)
      if params[:date].present?
        @attendances = current_developer.attendances.gert_attendances(params[:date]).page(params[:page]).per(31)
      else
        @attendances = current_developer.attendances.page(params[:page]).per(31)
      end
    else
     flash['success'] = "Please kindly contact to your HR for creating your attendances record."
    end
    
  end

  
  def get_developer_profile
    @developer = current_developer
  end

  def punch_out
    punch_date = current_developer.attendances.where("created_at::date=?",Date.current).first 
    total_work_min = (Time.current - punch_date.punch_in_time)/60
    hour, min = total_work_min.divmod(60)
    work_hour = "%02d hour: %02d min" % [hour, min]


    extra_work_total_min = (punch_date.punch_out_at * 60) 
    early_out_datetime = ((Time.current.hour * 60) + Time.current.min)


    if early_out_datetime > extra_work_total_min
      total_extra_min = early_out_datetime - extra_work_total_min
      hour, min = total_extra_min.divmod(60)
      @extra_work = "%02d hour: %02d min" % [hour, min]
    end

    punch_date.update(punch_out_time: Time.current, early_out:Time.current,work_hour: work_hour, extra_work:@extra_work, punch_out_status: true)
    redirect_to attendances_url, notice:"Punch Out successfully."
  end

  private

  

end
