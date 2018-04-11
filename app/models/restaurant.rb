class Restaurant < ApplicationRecord
  validates_presence_of :name, :zipcode
  validates_uniqueness_of :name, scope: [:zipcode]
  before_save :generate_slug, if: :name_changed?
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :users, through: :user_roles
  has_many :recipes, dependent: :destroy

  def stations
    recipes.pluck(:station).uniq
  end

  def to_param
    slug
  end

  private

    def generate_slug
      self.slug = name.parameterize
    end

end
