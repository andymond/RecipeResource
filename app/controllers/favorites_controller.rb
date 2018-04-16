class FavoritesController < ApplicationController

  def index
    @recipes = current_user.recipes
  end

  def create
    Favorite.find_or_create_by(favorite_params)
  end

  def destroy
    fav = Favorite.find_by(favorite_params)
    fav.destroy
  end

  private

    def favorite_params
      params.permit(:user_id, :recipe_id)
    end

end
