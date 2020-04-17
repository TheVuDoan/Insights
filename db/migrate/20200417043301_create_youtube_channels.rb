class CreateYoutubeChannels < ActiveRecord::Migration[5.2]
  def change
    create_table :youtube_channels do |t|
      t.string :title, null: false
      t.string :channel_id, null: false

      t.timestamps
    end
  end
end
