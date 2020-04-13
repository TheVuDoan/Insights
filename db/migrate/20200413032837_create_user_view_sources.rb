class CreateUserViewSources < ActiveRecord::Migration[5.2]
  def change
    create_table :user_view_sources do |t|
      t.integer :user_id, null: false
      t.integer :source_id, null: false
      t.integer :count, null: false, default: 1

      t.timestamps
    end

    add_index :user_view_sources, :user_id
    add_index :user_view_sources, :source_id
  end
end
