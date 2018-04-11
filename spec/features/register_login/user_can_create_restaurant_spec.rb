require "rails_helper"

describe "user can create a new restaurant" do
  it "allows user to create restaurant" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    expect(current_path).to eq(new_restaurant_path)

    VCR.use_cassette "Create Restaurant Yelp No Match" do
      fill_in "restaurant", with: "Best Test1234"
      fill_in "restaurant_zip", with: "12345"
      click_on "Register"
    end

    expect(current_path).to eq(dashboard_index_path)
    expect(page).to have_content("Successfully Registered Restaurant!")
  end
end
