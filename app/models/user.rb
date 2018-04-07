class User < ApplicationRecord
  validates_uniqueness_of :email
  validates_presence_of :email, :first_name, :last_name
  include ActiveModel::Validations
  validates_with CredentialValidator
  has_one :app_credential, dependent: :destroy
  has_one :google_credential, dependent: :destroy
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :restaurants, through: :user_roles

  def set_restaurant(attrs)
    set_default_role
    restaurant = Restaurant.create(name: attrs[:name], zipcode: attrs[:zipcode])
    user_roles.last.update(restaurant_id: restaurant.id)
  end

  def self.update_or_create(auth)
   gc = GoogleCredential.find_by(uid: auth[:uid]) || GoogleCredential.new
   gc.attributes = {
         provider: auth[:provider],
         uid: auth[:uid],
         token: auth[:credentials][:token],
         refresh_token: auth[:credentials][:refresh_token],
         oauth_expires_at: auth[:credentials][:expires_at]
       }
   user = gc.update_or_create({
         email: auth[:info][:email],
         first_name: auth[:info][:first_name],
         last_name: auth[:info][:last_name],
         image_url: auth[:info][:image]
       })
   user.save!
   gc.save!
   user
  end

  private

    def set_default_role
      roles.find_or_create_by(name: "chef")
    end

end
