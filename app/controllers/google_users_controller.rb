class GoogleUsersController < ApplicationController

  def create
    session[:restaurant_name] = params[:restaurant]
    session[:restaurant_zip] =  params[:restaurant_zip]
    redirect_to "/auth/google"
  end

end
