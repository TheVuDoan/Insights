# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

require_relative "environment"

set :environment, Rails.env

set :bundle_command, "/usr/local/bin/bundle exec"

every :hour do
  rake "crawl_news_rss:run"
end

every 1.day, at: ['11:00 am', '5:00 pm', '11:00 pm'] do
  rake "crawl_youtube_videos:run"
end