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
  has_many :favorites, dependent: :destroy
  has_many :recipes, through: :favorites

  def is_site_admin?
    roles.exists?("site admin")
  end

  def is_chef?
    roles.exists?(name: "chef")
  end

  def is_cook?
    roles.exists?(name: "cook")
  end

  def set_restaurant(attrs)
    set_role("chef")
    search = YelpSearchService.new
    restaurant = search.update_restaurant(attrs)
    user_roles.last.update(restaurant_id: restaurant.id)
  end

  def cooks_at(restaurant)
    set_role("cook")
    user_roles.last.update(restaurant_id: restaurant.id)
  end

  def restaurant_role(role, slug)
    set_role(role)
    restaurant = Restaurant.find_by(slug: slug)
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

    def set_role(role)
      r = Role.find_or_create_by(name: role)
      user_roles.find_or_create_by(role_id: r.id, user_id: self.id)
    end

end
