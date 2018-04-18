require "rails_helper"

describe "As a user" do
  it "can edit profile information", js: true do
    user = create(:cook)

    visit root_path

    find('.login').click

    fill_in "login_email", with: user.email
    fill_in "login_password", with: user.app_credential.password

    VCR.use_cassette "No Reviews" do
      click_on "Log in"
    end

    VCR.use_cassette "No Reviews" do
      visit root_path
    end

    find(".open-card").click

    VCR.use_cassette "No Reviews" do
      within ".user-card" do
        find(".update-profile").click
      end
    end

    expect(current_path).to eq(edit_user_path(user))

    fill_in "user_first_name", with: "New Name"
    fill_in "user_last_name", with: "New Last Name"

    VCR.use_cassette "No Reviews" do
      click_on "Update Profile"
    end

    expect(current_path).to eq(dashboard_index_path)
    expect(page).to have_content("Successfully updated profile")

    find(".open-card").click

    expect(page).to have_content("New Name".upcase)
    expect(page).to have_content("New Last Name".upcase)
  end
end
