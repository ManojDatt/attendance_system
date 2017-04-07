# # Use this file to easily define all of your cron jobs.
# #
# # It's helpful, but not entirely necessary to understand cron before proceeding.
# # http://en.wikipedia.org/wiki/Cron

# # Example:
# #
# set :output, "#{path}/log/cron.log"
# #
# # every 2.hours do
# #   command "/usr/bin/some_great_command"
# #   runner "MyModel.some_method"
# #   rake "some:great:rake:task"
# # end
# #
# # every 4.days do
# #   runner "AnotherModel.prune_old_records"
# # end

# # Learn more: http://github.com/javan/whenever
# ##=== run once on every month
# # every '0 0 1 * *' do
# #   command "echo 'you can use raw cron sytax too'"
# # end

# ##=== run every minutes
# ###===   here cron code is as : (min (0 - 59), hour (0 - 23), day of month (1 - 31), month (1 - 12), day of week (0 - 6) (Sunday=0)) 
# every '1 * * * *' do
#   command "echo 'you can use raw cron sytax too'"
#   runner "Attendance.create_objects"
#   rake "attendance:create_dev"
# end

# every 1.minute do
#   command "echo 'you can use raw cron sytax too'"
# end


# ##=http://www.manpagez.com/man/5/crontab/
# # string          meaning
# # ------          -------
# # @reboot         Run once, at startup.
# # @yearly         Run once a year, "0 0 1 1 *".
# # @annually       (same as @yearly)
# # @monthly        Run once a month, "0 0 1 * *".
# # @weekly         Run once a week, "0 0 * * 0".
# # @daily          Run once a day, "0 0 * * *".
# # @midnight       (same as @daily)
# # @hourly         Run once an hour, "0 * * * *".