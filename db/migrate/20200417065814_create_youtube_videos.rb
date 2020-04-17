class CreateYoutubeVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :youtube_videos do |t|
      t.string :title, null: false
      t.references :youtube_channel, foreign_key: true, null: false
      t.datetime :published_at, null: false
      t.integer :view_count, null: false, default: 0
      t.integer :like_count, null: false, default: 0
      t.integer :dislike_count, null: false, default: 0
      t.string :embed_html, null: false

      t.timestamps
    end
  end
end
