class RemoveColumnsFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :provider
    remove_column :users, :uid
    remove_column :users, :token
    remove_column :users, :refresh_token
    remove_column :users, :oauth_expires_at
  end
end
