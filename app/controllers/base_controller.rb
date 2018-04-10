class BaseController < ApplicationController
  before_action :has_restaurant?

  private

    def has_restaurant?
      if current_user.restaurants.empty?
        flash[:notice] = "You don't belong to a restaurant yet!"
        redirect_to new_restaurant_path
      end
    end
end
