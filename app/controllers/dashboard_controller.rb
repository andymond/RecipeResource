class DashboardController < BaseController

  def index
    @recipes = current_restaurant.recipes
  end

end
