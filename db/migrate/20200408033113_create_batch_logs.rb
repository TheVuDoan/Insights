class CreateBatchLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :batch_logs do |t|
      t.string :batch, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at
      t.integer :result
      t.index [:batch, :result]

      t.timestamps
    end
  end
end
