require "rails_helper"

describe "User profile side bar" do
  it "displays 3 most recent yelp reviews for restaurant" do
    user = create(:user)
    restaurant = Restaurant.create(name: "Departure", zipcode: "80206")
    role = Role.create(name: "chef")
    user.user_roles.create(user_id: user.id, restaurant_id: restaurant.id, role_id: role.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette "Yelp Reviews" do
      visit dashboard_index_path
      find(".open-card").click
    end

    expect(page).to have_content("yelp review 1")
    expect(page).to have_content("yelp review 2")
    expect(page).to have_content("yelp review 3")
  end
end
