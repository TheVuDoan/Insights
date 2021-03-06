class CreateViews < ActiveRecord::Migration[5.2]
  def change
    create_table :views do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.integer :count, null: false, default: 1
      
      t.timestamps
    end

    add_index :views, :user_id
    add_index :views, :post_id
  end
end
