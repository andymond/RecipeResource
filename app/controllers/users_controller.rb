class UsersController < ApplicationController

  def create
    app_credential = AppCredential.new(credential_params)
    user = app_credential.create_user(user_params)
    if app_credential.save && user.save
      user.set_restaurant(name: params[:restaurant], zipcode: params[:restaurant_zip])
      flash[:notice] = "Account created!"
      session[:user_id] = user.id
      redirect_to dashboard_index_path
    else
      flash[:error] = "Couldn't create account."
      redirect_to root_path
    end
  end

  private

    def user_params
      params.permit(:first_name, :last_name, :email)
    end

    def credential_params
      params.permit(:password, :password_confirmation)
    end

end
