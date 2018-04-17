require "rails_helper"

describe "As a chef" do
  it "user can upload images for recipes", js: true do
    user   = create(:chef)
    recipe = user.restaurants.first.recipes.create(name: "chicken", station: "grill")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette "No Reviews" do
      visit restaurant_recipe_path(user.restaurants.first, recipe.slug)
    end

    VCR.use_cassette "No Reviews" do
      find("#add-image-to-recipe").click
    end

    expect(current_path).to eq(new_chef_restaurant_recipe_image_path(user.restaurants.first, recipe.slug))

    attach_file('file', File.absolute_path('./app/assets/images/tray.png'))

    VCR.use_cassette "No Reviews" do
      click_on "Add Image for Chicken"
    end

    expect(current_path).to eq(restaurant_recipe_path(user.restaurants.first, recipe))
    expect(page).to have_content("Image added to Chicken!")
  end
end
