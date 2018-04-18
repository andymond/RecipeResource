class CommentsController < ApplicationController

  def create
    session[:return_to] ||= request.referer
    recipe = Recipe.find_by(slug: params[:recipe_slug])
    recipe.comments.create(author: current_user.first_name, body: params[:body])
    redirect_to session.delete(:return_to)
  end

end
