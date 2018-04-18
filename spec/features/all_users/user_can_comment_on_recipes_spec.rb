require "rails_helper"

describe "A user" do
  it "can comment on existing recipes" do
    user       = create(:cook)
    restaurant = user.restaurants.first
    recipe     = restaurant.recipes.create(name: "testipe", station: "test")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette "No Reviews" do
      visit restaurant_recipe_path(restaurant, recipe)
    end
    
    within ".comment-form" do
      fill_in "body", with: "Where are the ingredients and instructions?"
    end
    VCR.use_cassette "No Reviews" do
      click_on "Comment"
    end

    expect(current_path).to eq(restaurant_recipe_path(restaurant, recipe))
    expect(page).to have_content("Where are the ingredients and instructions?")
  end
end
