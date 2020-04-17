namespace :crawl_youtube_videos do
  task run: :environment do |_task, _args|
    CrawlYoutubeVideos.execute
  end
end