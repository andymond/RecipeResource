class CreateInstructions < ActiveRecord::Migration[5.1]
  def change
    create_table :instructions do |t|
      t.text :step
      t.references :recipe, foreign_key: true
    end
  end
end
