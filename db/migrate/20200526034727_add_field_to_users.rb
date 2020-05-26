class AddFieldToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :confirmation_token, :string, after: :remember_created_at
    add_column :users, :confirmed_at, :datetime, after: :confirmation_token
    add_column :users, :confirmation_sent_at, :datetime, after: :confirmed_at
    add_column :users, :unconfirmed_email, :string, after: :confirmation_sent_at
  end
end
