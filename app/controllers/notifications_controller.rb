class NotificationsController < ApplicationController

  def new
  end

  def create
    UserNotifier.invite(current_restaurant, params[:role], params[:user_email]).deliver_now
    flash[:notice] = "Invited user to join #{current_restaurant.name}!"
    redirect_to dashboard_index_path
  end

end
