class Chef::RestaurantsController < ApplicationController

  def edit
    @restaurant = current_user.restaurants.find_by(slug: params[:slug])
  end

  def update
    restaurant = current_user.restaurants.find_by(slug: params[:slug])
    restaurant.update(restaurant_params)
    flash[:notice] = "Successfully updated restaurant info."
    redirect_to restaurant_path(restaurant)
  end

  private

    def restaurant_params
      params.require(:restaurant).permit(:name, :phone_number, :address, :zipcode)
    end

end
