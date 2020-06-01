class AddRecommendToViews < ActiveRecord::Migration[5.2]
  def change
    add_column :views, :recommend_view_count, :integer, null: false, default: 0, after: :count
  end
end
