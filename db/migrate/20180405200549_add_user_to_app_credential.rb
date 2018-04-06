class AddUserToAppCredential < ActiveRecord::Migration[5.1]
  def change
    add_reference :app_credentials, :user, foreign_key: true
  end
end
