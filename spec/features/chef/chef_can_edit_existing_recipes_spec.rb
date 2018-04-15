require "rails_helper"

describe "As a chef" do
  it "allows user to edit existing recipes", js: true do
    user = create(:chef)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    recipe = user.restaurants.first.recipes.create(name: "Cat food", station: "cat station")
    recipe.ingredients.create(name: "fish")
    recipe.ingredients.create(name: "milk")
    recipe.instructions.create(step: "mix fish and milk together")
    recipe.instructions.create(step: "your cat will love it!")

    VCR.use_cassette "No Reviews" do
      visit root_path
    end

    VCR.use_cassette "No Reviews" do
      find(".cat-food").click
    end

    VCR.use_cassette "No Reviews" do
      find(".show-edit-recipe").click
    end

    expect(current_path).to eq(edit_chef_restaurant_recipe_path(user.restaurants.first, recipe))

    find('#ingredient-data2').click
    find('#ingredient-data2').set("beer")
    click_on "Add Ingredient"
    find('#ingredient1').set("kix")
    find('#instruction-data1').set("mix fish, kix and beer together")

    VCR.use_cassette "No Reviews" do
      click_on"Update Recipe"
    end

    expect(current_path).to eq(restaurant_recipe_path(user.restaurants.first, recipe))
    expect(page).to have_content("mix fish, kix and beer together")
  end
end
