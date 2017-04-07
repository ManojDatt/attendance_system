require 'clockwork'
require './config/boot'
require './config/environment'
module Clockwork
  handler do |job|
    puts "Running #{job}"
  end
  every(59.seconds, 'Demo'){ Developer.create_attendance}
end
