class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.string :yid
      t.string :image_url
      t.string :rating
      t.string :address
      t.string :phone_number

      t.timestamps
    end
  end
end
