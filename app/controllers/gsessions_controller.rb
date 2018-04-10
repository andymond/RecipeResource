class GsessionsController < ApplicationController

  def create
    user       = User.update_or_create(request.env["omniauth.auth"])
    if session[:restaurant_name].nil?
      session[:user_id] = user.id
      flash[:notice] = "Welcome, #{user}"
      redirect_to dashboard_index_path
    elsif user.set_restaurant(name: session[:restaurant_name], zipcode: session[:restaurant_zip])
      session[:user_id] = user.id
      flash[:notice] = "Successfully registered with Google"
      redirect_to dashboard_index_path
    else
      flash[:error] = "Restaurant Already Exists!"
      redirect_to root_path
    end
  end

end
