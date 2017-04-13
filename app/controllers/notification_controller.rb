class NotificationController < ApplicationController
  layout "developer_layout"
  before_action :authenticate_developer!
  
  def index
  	@notifications = current_developer.notifications.where(unseen:true, notification_type:'dsr-reply')
  	@notifications.update(unseen:false)
  end
end
