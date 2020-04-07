class AddCategoryToPost < ActiveRecord::Migration[5.2]
  def change
    change_table :posts do |t|
      t.references :category, foreign_key: true, null: false
    end
  end
end
