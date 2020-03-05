class CreateSources < ActiveRecord::Migration[5.2]
  def change
    create_table :sources do |t|
      t.string :name
      t.string :url
      t.string :logo
      t.string :icon
      t.timestamps
    end
  end
end
