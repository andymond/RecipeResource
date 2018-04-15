require "rails_helper"

describe "As a cook" do
  let(:user)       { create(:cook ) }
  let(:restaurant) { user.restaurants.first }

  it "displays a list of all recipes on dashboard" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    restaurant.recipes.create(name: "squash ravioli", station: "pasta")
    restaurant.recipes.create(name: "steak", station: "saute")
    restaurant.recipes.create(name: "blue cheese salad", station: "garde a mange")
    restaurant.recipes.create(name: "cobb salad", station: "garde a mange")
    restaurant.recipes.create(name: "artisan doughnuts", station: "pastry")

    VCR.use_cassette "No Reviews" do
      visit dashboard_index_path
    end

    restaurant.recipes.each do |recipe|
      expect(page).to have_link(recipe.name)
      expect(page).to have_link(recipe.station)
    end
  end

  it "allows user to filter recipes by station" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    recipe_1 = restaurant.recipes.create(name: "squash ravioli", station: "pasta")
    recipe_2 = restaurant.recipes.create(name: "steak", station: "saute")
    recipe_3 = restaurant.recipes.create(name: "blue cheese salad", station: "garde a mange")
    recipe_4 = restaurant.recipes.create(name: "cobb salad", station: "garde a mange")
    recipe_5 = restaurant.recipes.create(name: "artisan doughnuts", station: "pastry")

    VCR.use_cassette "No Reviews" do
      visit dashboard_index_path
    end

    VCR.use_cassette "No Reviews" do
      click_on recipe_1.station
    end
    expect(current_url).to eq(restaurant_recipes_url(restaurant, station: recipe_1.station))
    expect(page).to have_content(recipe_1.name)
    expect(page).to_not have_content(recipe_2.name)

    VCR.use_cassette "No Reviews" do
      click_on recipe_3.station
    end
    expect(current_url).to eq(restaurant_recipes_url(restaurant, station: recipe_3.station))
    expect(page).to have_content(recipe_3.name)
    expect(page).to have_content(recipe_4.name)
    expect(page).to_not have_content(recipe_1.name)

    VCR.use_cassette "No Reviews" do
      click_on recipe_2.station
    end
    expect(current_url).to eq(restaurant_recipes_url(restaurant, station: recipe_2.station))
    expect(page).to have_content(recipe_2.name)
    expect(page).to_not have_content(recipe_4.name)

    VCR.use_cassette "No Reviews" do
      click_on recipe_5.station
    end
    expect(current_url).to eq(restaurant_recipes_url(restaurant, station: recipe_5.station))
    expect(page).to have_content(recipe_5.name)
    expect(page).to_not have_content(recipe_1.name)
  end
end
