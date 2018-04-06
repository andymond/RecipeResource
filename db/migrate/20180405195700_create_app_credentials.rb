class CreateAppCredentials < ActiveRecord::Migration[5.1]
  def change
    create_table :app_credentials do |t|
      t.string :password_digest
    end
  end
end
