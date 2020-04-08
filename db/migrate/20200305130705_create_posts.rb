class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.datetime :publish_date
      t.text :description
      t.references :source, foreign_key: true, null: false
      t.string :image
      t.string :url
      t.string :status

      t.timestamps
    end
  end
end