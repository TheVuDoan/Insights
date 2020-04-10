class CreateViews < ActiveRecord::Migration[5.2]
  def change
    create_table :views do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.integer :count, null: false, default: 1
      
      t.timestamps
    end
  end
end
