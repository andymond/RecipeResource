class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorize!

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
    current_user.restaurants.first if current_user
  end

  def current_permission
    restaurant = Restaurant.find_by(slug: params[:restaurant_slug]) || current_restaurant
    @current_permission ||= Permission.new(current_user, restaurant)
  end

  def current_stations
    current_restaurant.stations
  end

  def current_role
    join = current_user.user_roles.find_by(restaurant_id: current_restaurant.id)
    current_user.roles.find(join.role_id).name
  end

  def authorize!
    unless authorized?
      flash[:error] = "Resource not found"
      redirect_to dashboard_index_url
    end
  end

  def authorized?
    current_permission.allow?(params[:controller], params[:action])
  end

end
