require 'clockwork'
require './config/boot'
require './config/environment'
module Clockwork
  handler do |job|
    puts "Running #{job}"
  end
  every(59.seconds, 'attendance created by start of month')#{ Attendance.run_monthlly}
  every(1.day, 'attendance created by start of month', at: '01:00', :if => lambda { |t| t.day == 1 }) do Attendance.run_monthlly end
end