class AddSlugToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :slug, :string
  end
end
