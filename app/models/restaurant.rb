class Restaurant < ApplicationRecord
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :users, through: :user_roles
  validates_presence_of :name, :zipcode
  validates_uniqueness_of :name, scope: [:zipcode]
  before_save :generate_slug, if: :name_changed?

  private

    def generate_slug
      self.slug = name.parameterize
    end

end
