require "rails_helper"

describe "As a user with role 'chef'" do
  it "allows chef to create a new recipe", js: true do
    user = create(:chef)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette "No Reviews" do
      visit root_path
    end

    VCR.use_cassette "No Reviews" do
      click_on "New Recipe"
    end
    expect(current_path).to eq(new_chef_restaurant_recipe_path(user.restaurants.first))

    fill_in "recipe_name", with: "Aromatic Fatty Dressing"
    fill_in "recipe_station", with: "garde a mange"

    click_on "Add Ingredient"
    fill_in "ingredient1", with: "coconut milk"
    click_on "Add Ingredient"
    fill_in "ingredient2", with: "lemongrass"
    click_on "Add Ingredient"
    fill_in "ingredient3", with: "fish sauce"

    click_on "Add Instruction"
    fill_in "instruction1", with: "slice lemongrass finely"
    click_on "Add Instruction"
    fill_in "instruction2", with: "Mix ingredents and season with lime to taste"

    click_on "Recipe Complete"

    expect(current_path).to eq(restaurant_recipe_path(user.restaurants.first, user.restaurants.first.recipes.last))
    expect(page).to have_content("Aromatic Fatty Dressing")
    expect(page).to have_content("coconut milk")
    expect(page).to have_content("lemongrass")
    expect(page).to have_content("fish sauce")
    expect(page).to have_content("slice lemongrass finely")
    expect(page).to have_content("Mix ingredents and season with lime to taste")
  end
end
