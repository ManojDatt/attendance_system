class DsrChannel < ApplicationCable::Channel
  def subscribed
    stream_from "dsr_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def notify(data)
  	ActionCable.server.broadcast "dsr_channel", data['message']
  end
end
