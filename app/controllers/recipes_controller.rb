class RecipesController < ApplicationController

  def index
    @recipes = Recipe.filter_by_station(params[:station])
  end

end
