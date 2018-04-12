class Recipe < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name, { scope: :restaurant_id }
  before_save :generate_slug, if: :name_changed?
  before_save :downcase_station
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :instructions
  belongs_to :restaurant

  def to_param
    slug
  end

  def self.filter_by_station(station)
    where(station: station)
  end

  private

    def generate_slug
      self.slug = name.parameterize
    end

    def downcase_station
      self.station = station.downcase unless station.nil?
    end
end
