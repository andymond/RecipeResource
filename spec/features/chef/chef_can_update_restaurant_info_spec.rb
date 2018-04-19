require "rails_helper"

describe "As a user with role 'chef'" do
  it "allows me to edit restaurants' info" do
    user = create(:chef)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette "No Reviews" do
      visit restaurant_path(user.restaurants.first)
    end

    VCR.use_cassette "No Reviews" do
      click_on "Update Restaurant Info"
      expect(current_path).to eq(edit_chef_restaurant_path(user.restaurants.first.slug))
    end

    VCR.use_cassette "No Reviews" do
      fill_in "restaurant_name", with: "Custom Restaurant Name"
      fill_in "restaurant_address", with: "123 Fake Street"
      fill_in "restaurant_zipcode", with: "12345"
      fill_in "restaurant_phone_number", with: "3038150200"
      click_on "Update Info"
    end

    expect(current_path).to eq(restaurant_path(user.restaurants.first))
    expect(page).to have_content("Successfully updated restaurant info")
  end
end
