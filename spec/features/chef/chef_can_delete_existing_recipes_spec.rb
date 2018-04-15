require "rails_helper"

describe "As a chef" do
  it "it allows user to delete existing recipes", js: true do
    user = create(:chef)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    user.restaurants.first.recipes.create(name: "Cat food", station: "cat station")

    VCR.use_cassette "No Reviews" do
      visit root_path
    end

    VCR.use_cassette "No Reviews" do
      find(".cat-food").click
    end

    VCR.use_cassette "No Reviews" do
      find(".show-edit-recipe").click
    end

    VCR.use_cassette "No Reviews" do
      find(".delete-recipe").click
    end

    expect(current_path).to eq(dashboard_index_path)
    expect(page).to_not have_css(".cat-food")
  end
end
