class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :author
      t.text :body
      t.references :recipe, foreign_key: true
    end
  end
end
