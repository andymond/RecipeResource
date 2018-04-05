class SessionsController < ApplicationController

  def create
    user = User.update_or_create(request.env["omniauth.auth"])
    session[:user_id] = user.id
    flash[:notice] = "Successfully registered with Google"
    redirect_to dashboard_index_path
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
