class CreateGoogleCredentials < ActiveRecord::Migration[5.1]
  def change
    create_table :google_credentials do |t|
      t.string :provider
      t.string :uid
      t.string :token
      t.string :refresh_token
      t.datetime :oauth_expires_at

      t.timestamps
    end
  end
end
