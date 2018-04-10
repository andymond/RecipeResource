require "rails_helper"

describe Ingredient do
  describe "relationships" do
    it {should have_many(:recipe_ingredients)}
    it {should have_many(:recipes)}
  end

  describe "validations" do
    it {should validate_uniqueness_of(:name)}
  end
end
