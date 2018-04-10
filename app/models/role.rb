class Role < ApplicationRecord
  validates_uniqueness_of :name
  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles
  has_many :restaurants, through: :user_roles
end
