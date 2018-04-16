class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user,
                :current_reviews,
                :current_restaurant,
                :current_stations,
                :current_role

  def current_user
    @user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_reviews
    @reviews ||= Review.new(current_user.restaurants.first)
  end

  def current_restaurant
    current_user.restaurants.first
  end

  def current_stations
    current_restaurant.stations
  end

  def current_role
    join = current_user.user_roles.find_by(restaurant_id: current_restaurant.id)
    current_user.roles.find(join.role_id).name
  end

end
