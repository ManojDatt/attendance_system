class DsrJob < ApplicationJob
  queue_as :default

 def perform(data)
    ActionCable.server.broadcast "dsr_channel",{message: "mark attenadances", developer: "manoj dutt"}
  end
end
