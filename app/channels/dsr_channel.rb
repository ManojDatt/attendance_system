class DsrChannel < ApplicationCable::Channel
  def subscribed
    stream_from "admin"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
