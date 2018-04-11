class Recipe < ApplicationRecord
  validates_uniqueness_of :name
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :instructions
  belongs_to :restaurant

  def self.filter_by_station(station)
    where(station: station)
  end
end
