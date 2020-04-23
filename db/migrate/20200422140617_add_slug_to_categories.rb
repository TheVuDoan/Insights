class AddSlugToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :slug, :string, after: :name
  end
end
