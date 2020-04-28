class AddSlugToSources < ActiveRecord::Migration[5.2]
  def change
    add_column :sources, :slug, :string, after: :name
  end
end
