require "rails_helper"

describe Recipe do
  describe "relationships" do
    it {should have_many(:recipe_ingredients)}
    it {should have_many(:ingredients)}
    it {should belong_to(:restaurant)}
    it {should have_many(:favorites)}
    it {should have_many(:users)}
  end

  describe "validations" do
    it {should validate_uniqueness_of(:name).scoped_to(:restaurant_id)}
  end

  describe "class methods" do
    it "filters recipes by station" do
      restaurant = create(:restaurant)
      recipe_1 = restaurant.recipes.create(name: "soup", station: "garde a mange")
      recipe_2 = restaurant.recipes.create(name: "salad", station: "garde a mange")
      recipe_3 = restaurant.recipes.create(name: "pork loin", station: "saute")

      expect(Recipe.filter_by_station("garde a mange")).to eq([recipe_1, recipe_2])
      expect(Recipe.filter_by_station("saute")).to eq([recipe_3])
    end
  end
end
