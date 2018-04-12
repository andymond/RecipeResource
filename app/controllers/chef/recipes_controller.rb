class Chef::RecipesController < ApplicationController
  def new

  end

  def create
    if Recipe.exists?(name: recipe_details[:name], restaurant_id: current_restaurant.id)
      flash[:notice] = "Recipe already exists!"
      render :new
    else
      rc = RecipeCoordinator.new(current_restaurant, recipe_details)
      recipe = rc.create_recipe
      flash[:notice] = "Successfully created #{recipe.name}"
      redirect_to restaurant_recipe_path(current_restaurant, recipe)
    end
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
      params.require(:ingredients).permit!.to_h
    end

    def instruction_params
      params.require(:instructions).permit!.to_h
    end

    def qty_params
      params.require(:qty).permit!.to_h
    end

    def unit_params
      params.require(:unit).permit!.to_h
    end


end
