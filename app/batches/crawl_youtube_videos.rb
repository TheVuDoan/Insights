class CrawlYoutubeVideos < ApplicationBatch
  private

  def process
    YoutubeChannel.all.each do |youtube_channel|
      channel = Yt::Channel.new id: youtube_channel.channel_id
      channel.videos.each do |video|
        if video.published_at > 6.hours.ago
          YoutubeVideo.create(
            youtube_id: video.id,
            title: video.title,
            thumbnail_url: video.thumbnail_url(size = :high),
            youtube_channel_id: youtube_channel.id,
            published_at: video.published_at,
            view_count: video.view_count,
            like_count: video.like_count,
            dislike_count: video.dislike_count,
            embed_html: video.embed_html
          )
        else
          break
        end
      end
    end
  end
end