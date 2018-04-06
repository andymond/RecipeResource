class AppCredential < ApplicationRecord
  has_secure_password
  validates_presence_of :password
  validates_confirmation_of :password, message: "passwords must match"
  belongs_to :user
end
