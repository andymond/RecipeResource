require "rails_helper"

describe Restaurant do
  describe "relationships" do
    it {should have_many(:user_roles)}
    it {should have_many(:roles)}
    it {should have_many(:users)}
    it {should have_many(:recipes)}
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:zipcode)}
    it {should validate_uniqueness_of(:name).scoped_to(:zipcode)}
  end

  describe "instance methods" do
    it "#stations" do
      restaurant = create(:restaurant)
      restaurant.recipes.create(name: "soup", station: "garde a mange")
      restaurant.recipes.create(name: "salad", station: "garde a mange")
      restaurant.recipes.create(name: "pork loin", station: "saute")

      expect(restaurant.stations).to eq(["garde a mange", "saute"])
    end
  end
end
