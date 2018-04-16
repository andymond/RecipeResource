class Recipe < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name, { scope: :restaurant_id }
  before_save :generate_slug, if: :name_changed?
  before_save :titleize_name
  before_save :downcase_station
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :instructions, dependent: :destroy
  belongs_to :restaurant
  has_many :favorites
  has_many :users, through: :favorites

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

    def titleize_name
      self.name = name.titleize unless station.nil?
    end
end
