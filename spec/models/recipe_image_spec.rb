require "rails_helper"

describe RecipeImage do
  describe "relationships" do
    it {should belong_to(:recipe)}
  end
end
