require "rails_helper"

describe "A registered user" do
  it "can view all images associated with an image" do
    user = create(:cook)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    recipe = user.restaurants.first.recipes.create(name: "Fruit roll up", station: "Candy")


    VCR.use_cassette "No Reviews" do
      visit restaurant_recipe_path(user.restaurants.first, recipe)
    end

    VCR.use_cassette "No Reviews" do
      find("#view-all-recipe-images").click
    end

    expect(current_path).to eq(restaurant_recipe_recipe_images_path(user.restaurants.first, recipe))
  end
end
