require "rails_helper"

describe "authentication" do
  it "allows user to register without google account" do
    visit root_path

    # find('.register').click
    within('.register-form') do
      fill_in "username", with: "Test name"
      fill_in "email", with: "test@email.com"
      fill_in "password", with: "password"
      fill_in "password_confirmation", with: "password"
      click_on "Register"
    end

    expect(current_path).to eq dashboard_index_path
    expect(page).to have_content("Test name")
  end
end
