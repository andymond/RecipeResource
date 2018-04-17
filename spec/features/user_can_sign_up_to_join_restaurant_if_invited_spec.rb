require "rails_helper"

describe "Invited user" do
  it "allows user to create account under existing restaurant" do
    chef = create(:chef)

    visit new_user_path(restaurant: chef.restaurants.first.slug, role: "cook")

    fill_in "first_name", with: "test user"
    fill_in "last_name", with: "test user"
    fill_in "email", with: "user"
    fill_in "password", with: "password"
    fill_in "password_confirmation", with: "password"

    VCR.use_cassette "No Reviews" do
      click_on "Join Restaurant"
    end

    expect(current_path).to eq(dashboard_index_path)
    expect(page).to have_content("Account created!")
  end
end
