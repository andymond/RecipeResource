class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :current_reviews

  def current_user
    @user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_reviews
    @reviews ||= ReviewsPresenter.new(current_user.restaurants.first)
  end

end
