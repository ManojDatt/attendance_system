require 'clockwork'
require './config/boot'
require './config/environment'
module Clockwork
  handler do |job|
    puts "Running #{job}"
  end
  every(1.hour, 'check 1st half on every 1 hour') do  Attendance.first_half end
  every(1.hour, 'check 2nd half on every 1 hour') do  Attendance.second_half end
  every(1.day, 'Attendance created by start of month', at: '03:00', :if => lambda { |t| t.day == 1 }) do Attendance.run_monthlly end
  every(1.day, "Add leave on every month's 1st day", at: '03:00', :if => lambda { |t| t.day == 1 }) do  Developer.add_leave end	
end