class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.datetime :publish_date
      t.text :description
      t.string :source
      t.string :image
      t.string :url

      t.timestamps
    end
  end
end
