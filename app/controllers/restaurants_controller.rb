class RestaurantsController < ApplicationController

  def show
    @restaurant = current_user.restaurants.first
  end

  def new
  end

  def create
    if current_user.set_restaurant(restaurant_params)
      flash[:notice] = "Successfully Registered Restaurant!"
      redirect_to dashboard_index_path
    else
      flash[:error] = "Couldn't Create Restaurant! Try another name/zip combo!"
      render :new
    end
  end

  private

    def restaurant_params
      {name: params[:restaurant], zipcode: params[:restaurant_zip]}
    end

end
