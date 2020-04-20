class CreateUserViewCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :user_view_categories do |t|
      t.integer :user_id, null: false
      t.integer :category_id, null: false
      t.integer :count, null: false, default: 1

      t.timestamps
    end

    add_index :user_view_categories, :user_id
    add_index :user_view_categories, :category_id
  end
end
