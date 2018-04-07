class AddZipToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :zipcode, :string
  end
end
