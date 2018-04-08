class AddYelpUrlToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :yelp_url, :text
  end
end
