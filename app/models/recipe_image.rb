class RecipeImage < ApplicationRecord
  validates_presence_of :recipe_image
  mount_uploader :recipe_image, RecipeImageUploader
  belongs_to :recipe
end
