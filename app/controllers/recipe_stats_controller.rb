class RecipeStatsController < ApplicationController

  def index
    @restaurant = current_restaurant
  end

end
