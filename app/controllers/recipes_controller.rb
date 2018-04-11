class RecipesController < ApplicationController

  def index
    @recipes = Recipe.filter_by_station(params[:station])
  end

  def show
    @recipe = RecipePresenter.new(params[:slug])
  end

end
