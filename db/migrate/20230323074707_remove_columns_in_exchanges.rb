class RemoveColumnsInExchanges < ActiveRecord::Migration[7.0]
  def up
    remove_column :exchanges, :email
    remove_column :exchanges, :encrypted_password
    remove_column :exchanges, :reset_password_token
    remove_column :exchanges, :reset_password_sent_at
    remove_column :exchanges, :remember_created_at
  end

  def down
    add_column :exchanges, :email, :string
    add_column :exchanges, :encrypted_password, :string
    add_column :exchanges, :reset_password_token, :string
    add_column :exchanges, :reset_password_sent_at, :string
    add_column :exchanges, :remember_created_at, :string
  end
end
