class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.integer :report_reason_id, null: false

      t.timestamps
    end
  end
end
