class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :station
      t.string :name
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
