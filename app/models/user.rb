class User < ApplicationRecord
  validates_uniqueness_of :email
  validates_presence_of :email, :first_name, :last_name
  before_save :authenticate!
  has_one :app_credential, dependent: :destroy
  has_one :google_credential, dependent: :destroy

  def self.update_or_create(auth)
   gc = GoogleCredential.find_by(uid: auth[:uid]) || GoogleCredential.new
   gc.attributes = {
         provider: auth[:provider],
         uid: auth[:uid],
         token: auth[:credentials][:token],
         refresh_token: auth[:credentials][:refresh_token],
         oauth_expires_at: auth[:credentials][:expires_at]
       }
   user = gc.create_user
   user.attributes = {
         email: auth[:info][:email],
         first_name: auth[:info][:first_name],
         last_name: auth[:info][:last_name],
         image_url: auth[:info][:image]
       }
   user.save!
   gc.save!
   user
  end

  # def authenticate(password)
  #   false unless user.app_credential.password == password
  # end

  private

    def authenticate!
      raise ActiveRecord::Rollback if (app_credential.nil? || app_credential.password_digest.nil?) && (google_credential.nil? || google_credential.uid.nil?)
    end

end
