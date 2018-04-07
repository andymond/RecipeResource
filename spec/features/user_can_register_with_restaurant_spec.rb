require "rails_helper"

describe "User registers with new restaurant" do
  it "allows user to register restaurant, and autogenerates yelp restaurant info" do
    url = "https://api.yelp.com/v3/businesses/search?term=jons-great-restaurant&location=80206&category=restaurants"
    stub_yelp_search("yelp_restaurants.json", url)

    visit root_path

    within(".register-form") do
      fill_in "restaurant", with: "Jon's Great Food Shack"
      fill_in "restaurant_zip", with: "80206"
      fill_in "email", with: "test@testmail.com"
      fill_in "first_name", with: "Jon"
      fill_in "last_name", with: "Chefman"
      fill_in "password", with: "password"
      fill_in "password_confirmation", with: "password"
      click_on "Register"
    end

    expect(current_path).to eq(dashboard_index_path)
    expect(page).to have_content("Account created!")

    click_on "Restaurant profile"

    expect(current_path).to eq("/restaurants/jons-great-food-shack")
    expect(page).to have_content("Jon's Great Food Shack")
    expect(page).to have_content("249 Columbine St")
    expect(page).to have_content("Denver, CO 80206")
    expect(page).to have_content("Rating: 3.5")
    expect(page).to have_content("(720) 772-5020")

    click_on "See all yelp reviews"

    expect(current_path).to include("https://www.yelp.com/biz")
  end
end
