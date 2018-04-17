require "rails_helper"

describe "As a chef" do
  it "allows user to invite new users to their restaurant" do
    user = create(:chef)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette "No Reviews" do
      visit root_path
    end

    VCR.use_cassette "No Reviews" do
      click_on "Invite New Team Member"
    end

    fill_in "user_email", with: "test@testmail.com"
    click_on "Invite Team Member"

    expect(current_path).to eq(dashboard_index_path)
    expect(page).to have_content("Invited user to join #{chef.restaurants.first.name}!")
  end
end
