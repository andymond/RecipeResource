class UsersController < ApplicationController

  def create
    user = User.new(user_params)
    user.create_app_credential(password: params[:password])
    if user.save
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

end
