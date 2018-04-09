class AddDefaultImageToRestaurants < ActiveRecord::Migration[5.1]
  def change
    change_column_default :restaurants, :image_url, "cutlery.svg"
  end
end
