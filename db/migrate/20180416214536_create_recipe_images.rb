class CreateRecipeImages < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_images do |t|
      t.string :recipe_image
      t.references :recipe, foreign_key: true
      t.string :caption
    end
  end
end
