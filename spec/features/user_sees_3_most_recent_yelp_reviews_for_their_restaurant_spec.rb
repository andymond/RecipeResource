require "rails_helper"

describe "User profile side bar" do
  it "displays 3 most recent yelp reviews for restaurant" do
    user = create(:user)
    restaurant = Restaurant.create(name: "Departure", zipcode: "80206", yid: "2ciJkwAoMAksdct4ABVv8w")
    role = Role.create(name: "chef")
    user.user_roles.create(user_id: user.id, restaurant_id: restaurant.id, role_id: role.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette "Yelp Reviews" do
      visit dashboard_index_path
      find(".open-card").click
    end

    expect(page).to have_content("amazing food - crispy bass + Departure wings\n\nThis restaurant is
    great and is the only reason I would ever venture into Cherry creek.")
    expect(page).to have_content("James A.")
    expect(page).to have_content("I wish I could give Departure 6 stars! I have been here 4 times in
    the past year, and it has been consistently excellent and one of my favorite
    restaurants...")
    expect(page).to have_content("Katy P.")
    expect(page).to have_content("We just stopped by for brunch and the food was AMAZING!! The service
    was also wonderful. Our server, Shane had great energy and made our experience
    fun!...")
    expect(page).to have_content("Heidi F.")
  end
end
