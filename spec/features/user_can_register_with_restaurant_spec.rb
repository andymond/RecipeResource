require "rails_helper"

describe "User registers with new restaurant" do
  it "allows user to register restaurant, and autogenerates yelp restaurant info" do
    VCR.use_cassette "Yelp Search" do
      visit root_path

      within(".register-form") do
        fill_in "restaurant", with: "Departure"
        fill_in "restaurant_zip", with: "80206"
        fill_in "email", with: "test@testmail.com"
        fill_in "first_name", with: "Jon"
        fill_in "last_name", with: "Chefman"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
        click_on "Register"
      end
    end

    VCR.use_cassette "Yelp Reviews" do
      expect(current_path).to eq(dashboard_index_path)
      expect(page).to have_content("Account created!")

      click_on "Restaurant profile"

      expect(current_path).to eq("/restaurants/departure")
      expect(page).to have_content("Departure")
      expect(page).to have_content("249 Columbine St")
      expect(page).to have_content("Denver, CO 80206")
      expect(page).to have_content("Yelp Rating: 3.5")
      expect(page).to have_content("(720) 772-5020")
    end

    page.assert_selector(:css, 'a[href="https://www.yelp.com/biz/departure-denver-3"]')
  end
end
