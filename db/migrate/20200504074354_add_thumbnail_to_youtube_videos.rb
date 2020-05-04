class AddThumbnailToYoutubeVideos < ActiveRecord::Migration[5.2]
  def change
    add_column :youtube_videos, :youtube_id, :string, after: :id
    add_column :youtube_videos, :thumbnail_url, :string, after: :title
  end
end
