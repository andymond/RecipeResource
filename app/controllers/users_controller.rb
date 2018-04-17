class UsersController < ApplicationController

  def create
    app_credential = AppCredential.new(credential_params)
    user = app_credential.create_user(user_params)
    if app_credential.save && user.save
      if params[:role].nil?
        user.set_restaurant(name: params[:restaurant], zipcode: params[:restaurant_zip])
        flash[:notice] = "Account created!"
        session[:user_id] = user.id
        redirect_to dashboard_index_path
      else
        user.restaurant_role(params[:role], params[:restaurant])
        flash[:notice] = "Account created!"
        session[:user_id] = user.id
        redirect_to dashboard_index_path
      end
    else
      flash[:error] = "Couldn't create account."
      redirect_to root_path
    end
  end

  def new
    @invite = invite_params
  end

  def edit
  end

  def update
    user = User.find(params[:id])
    if user.update(update_params)
      flash[:notice] = "Successfully updated profile"
      redirect_to dashboard_index_path
    else
      flash[:error] = "Couldn't update profile"
      render :edit
    end
  end

  private

    def user_params
      params.permit(:first_name, :last_name, :email)
    end

    def update_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end

    def credential_params
      params.permit(:password, :password_confirmation)
    end

    def invite_params
      params.permit(:role, :restaurant)
    end

end
