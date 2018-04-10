require "rails_helper"

describe Recipe do
  describe "relationships" do
    it {should have_many(:recipe_ingredients)}
    it {should have_many(:ingredients)}
    it {should belong_to(:restaurant)}
  end

  describe "validations" do
    it {should validate_uniqueness_of(:name)}
  end
end
