class SessionsController < ApplicationController
  
  def create
    user = User.find_by(email: params[:login_email])
    if user && user.app_credential.authenticate(params[:login_password])
      session[:user_id] = user.id
      redirect_to dashboard_index_path
    else
      flash[:error] = "Could not validate credentials"
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
