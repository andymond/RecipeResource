class AddTimestampsToAppCredentials < ActiveRecord::Migration[5.1]
  def change
    add_column :app_credentials, :created_at, :datetime, null: false
    add_column :app_credentials, :updated_at, :datetime, null: false
  end
end
