namespace :yt_test do
  task run: :environment do |_task, _args|
    channel = Yt::Channel.new id: 'UC47WI-kZXFf0H_f7pvaNCEQ' ## use any channel ID
    videos = channel.videos
    videos.each do |video|
      if video.published_at > 6.hours.ago
        puts video.thumbnail_url
      else
        break
      end
    end
    # puts channel.title
  end
end