class LeaveChannel < ApplicationCable::Channel
  def subscribed
     stream_from "admin:attendances"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
