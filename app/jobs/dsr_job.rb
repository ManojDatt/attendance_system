class DsrJob < ApplicationJob
  queue_as :default
 def perform(data)
 end
end
