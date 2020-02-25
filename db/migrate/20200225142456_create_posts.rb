class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.datetime :publish_date
      t.string :source
      t.string :image

      t.timestamps
    end
  end
end
