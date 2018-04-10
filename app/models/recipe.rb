class Recipe < ApplicationRecord
  validates_uniqueness_of :name
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :instructions
  belongs_to :restaurant
end
