class Restaurant < ApplicationRecord
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :users, through: :user_roles
  validates_uniqueness_of :name, scope: [:zipcode]
end
