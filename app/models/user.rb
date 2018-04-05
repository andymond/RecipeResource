class User < ApplicationRecord
  validates_uniqueness_of :email
  validates_presence_of :email
  before_save :authenticate
  has_one :app_credential, dependent: :destroy

  def self.update_or_create(auth)
   user = User.find_by(uid: auth[:uid]) || User.new
   user.attributes = {
     provider: auth[:provider],
     uid: auth[:uid],
     email: auth[:info][:email],
     first_name: auth[:info][:first_name],
     last_name: auth[:info][:last_name],
     image_url: auth[:info][:image],
     token: auth[:credentials][:token],
     refresh_token: auth[:credentials][:refresh_token],
     oauth_expires_at: auth[:credentials][:expires_at]
   }
   user.save!
   user
  end

  private

    def authenticate
      raise ActiveRecord::Rollback if app_credential.nil? || app_credential.password_digest.nil?
    end
end
