require "rails_helper"

describe Recipe do
  describe "relationships" do
    it {should have_many(:recipe_ingredients)}
    it {should have_many(:ingredients)}
    it {should belong_to(:restaurant)}
    it {should have_many(:favorites)}
    it {should have_many(:recipe_images)}
    it {should have_many(:users)}
    it {should have_many(:comments)}
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

    it "orders recipes by popularity" do
      user_1 = create(:cook)
      user_2 = create(:cook)
      user_3 = create(:cook)
      recipe_1 = user_1.restaurants.first.recipes.create(name: "soup", station: "garde a mange")
      recipe_1.favorites.create(user_id: user_1.id)
      recipe_1.favorites.create(user_id: user_2.id)
      recipe_2 = user_1.restaurants.first.recipes.create(name: "salad", station: "garde a mange")
      recipe_2.favorites.create(user_id: user_1.id)
      recipe_3 = user_1.restaurants.first.recipes.create(name: "pork loin", station: "saute")

      expect(Recipe.by_popularity.first).to eq(recipe_1)
      expect(Recipe.by_popularity.last).to eq(recipe_2)
    end
  end
end
