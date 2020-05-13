class AddViewCountToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :view_count, :integer, null: false, default: 0, after: :url
  end
end
