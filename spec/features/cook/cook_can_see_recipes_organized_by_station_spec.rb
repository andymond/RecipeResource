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
    restaurant.recipes.create(name: "squash ravioli", station: "pasta")
    restaurant.recipes.create(name: "steak", station: "saute")
    restaurant.recipes.create(name: "blue cheese salad", station: "garde a mange")
    restaurant.recipes.create(name: "cobb salad", station: "garde a mange")
    restaurant.recipes.create(name: "artisan doughnuts", station: "pastry")

    VCR.use_cassette "No Reviews" do
      visit dashboard_index_path
    end

    VCR.use_cassette "No Reviews" do
      click_on "pasta"
    end
    expect(current_url).to eq(restaurant_recipes_url(restaurant, station: "pasta"))
    expect(page).to have_content("squash ravioli")
    expect(page).to_not have_content("steak")

    VCR.use_cassette "No Reviews" do
      click_on "garde a mange"
    end
    expect(current_url).to eq(restaurant_recipes_url(restaurant, station: "garde a mange"))
    expect(page).to have_content("blue cheese salad")
    expect(page).to have_content("cobb salad")
    expect(page).to_not have_content("artisan doughnuts")

    VCR.use_cassette "No Reviews" do
      click_on "saute"
    end
    expect(current_url).to eq(restaurant_recipes_url(restaurant, station: "saute"))
    expect(page).to have_content("steak")
    expect(page).to_not have_content("cobb salad")

    VCR.use_cassette "No Reviews" do
      click_on "pastry"
    end
    expect(current_url).to eq(restaurant_recipes_url(restaurant, station: "pastry"))
    expect(page).to have_content("artisan doughnuts")
    expect(page).to_not have_content("squash ravioli")
  end
end
