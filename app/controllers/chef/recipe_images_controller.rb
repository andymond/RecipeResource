class Chef::RecipeImagesController < ApplicationController

  def new
    @recipe = current_restaurant.recipes.find_by(slug: params[:recipe_slug])
  end

  def create
    recipe = current_restaurant.recipes.find_by(slug: params[:recipe_slug])
    ri = recipe.recipe_images.new
    ri.recipe_image = params[:file]
    if ri.save!
      flash[:notice] = "Image added to #{recipe.name}!"
      redirect_to restaurant_recipe_path(current_restaurant, recipe)
    else
      flash[:error] = "Failed to add image!"
      render :new
    end
  end

  def destroy
    recipe = current_restaurant.recipes.find_by(slug: params[:recipe_slug])
    image  = RecipeImage.find(params[:id])
    image.destroy
    redirect_to restaurant_recipe_recipe_images_path(current_restaurant, recipe.slug)
  end
end
