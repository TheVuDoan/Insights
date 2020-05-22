class CreateReportReasons < ActiveRecord::Migration[5.2]
  def change
    create_table :report_reasons do |t|
      t.string :slug, null: false
      t.string :description, null: false

      t.timestamps
    end
  end
end
