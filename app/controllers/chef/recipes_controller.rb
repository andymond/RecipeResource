class Chef::RecipesController < ApplicationController

  def new

  end

  def create
    if Recipe.exists?(name: recipe_details[:name], restaurant_id: current_restaurant.id)
      flash[:error] = "Recipe already exists!"
      render :new
    else
      rc = RecipeCreator.new(current_restaurant, recipe_details)
      recipe = rc.create_recipe
      flash[:notice] = "Successfully created #{recipe.name}"
      redirect_to restaurant_recipe_path(current_restaurant, recipe)
    end
  end

  def edit
    @recipe = RecipePresenter.new(params[:slug])
  end

  def update
    ru = RecipeUpdater.new(recipe_update_params, params[:slug])
    if recipe = ru.update_recipe
      flash[:notice] = "Successfully updated #{recipe.name}"
      render :js => "window.location = '#{restaurant_recipe_path(current_restaurant, recipe)}'"
    else
      flash[:error] = "Recipe update failed!"
      render :edit
    end
  end

  def destroy
    recipe = current_restaurant.recipes.find_by(slug: params[:slug])
    recipe.destroy
    flash[:notice] = "Deleted #{recipe.name}"
    redirect_to root_path
  end

  private

    def recipe_details
      { name: recipe_params[:recipe_name],
        station: recipe_params[:recipe_station],
        ingredients: ingredient_params,
        qty: qty_params,
        unit: unit_params,
        instructions: instruction_params
       }
    end

    def recipe_params
      params.permit(:recipe_name, :recipe_station)
    end

    def ingredient_params
      params.require(:ingredients).permit!.to_h unless params[:ingredients].nil?
    end

    def instruction_params
      params.require(:instructions).permit!.to_h unless params[:instructions].nil?
    end

    def qty_params
      params.require(:qty).permit!.to_h unless params[:qty].nil?
    end

    def unit_params
      params.require(:unit).permit!.to_h unless params[:unit].nil?
    end

    def recipe_update_params
      params.require(:recipe).permit!.to_h
    end


end
