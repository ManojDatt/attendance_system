class DsrChannel < ApplicationCable::Channel
  def subscribed
    stream_from "dsr_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
