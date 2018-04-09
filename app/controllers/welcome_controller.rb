class WelcomeController < ApplicationController

  def index
    redirect_to dashboard_index_path unless current_user.nil?
  end

end
