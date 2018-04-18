class RecipeImagesController < ApplicationController

  def index
    @recipe  = current_restaurant.recipes.find_by(slug: params[:recipe_slug])
    @images = @recipe.recipe_images
  end

end
