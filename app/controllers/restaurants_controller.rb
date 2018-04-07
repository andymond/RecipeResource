class RestaurantsController < ApplicationController

  def show
    @restaurant = current_user.restaurants.first
  end

end
