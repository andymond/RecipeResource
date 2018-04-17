require "rails_helper"

describe "As a cook" do
  it "user can't create new recipes" do
    user = create(:cook)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette "No Reviews" do
      visit new_chef_restaurant_recipe_path(user.restaurants.first)
    end

    expect(current_path).to eq(dashboard_index_path)
    expect(page).to have_content("Resource not found")
  end
end
