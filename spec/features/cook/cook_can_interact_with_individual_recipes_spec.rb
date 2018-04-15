require "rails_helper"

describe "cook visits recipe show" do
  it "displays recipe instructions, ingredients, and image to cook" do
    user          = create(:cook)
    restaurant    = user.restaurants.first
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    recipe        = restaurant.recipes.create(name: "squash ravioli", station: "pasta")
    squash        = Ingredient.find_or_create_by(name: "squash")
    ravioli       = Ingredient.find_or_create_by(name: "ravioli")
    amount_1      = recipe.recipe_ingredients.create(ingredient_id: squash.id, quantity: 1.8, unit: "C")
    amount_2      = recipe.recipe_ingredients.create(ingredient_id: ravioli.id, quantity: 1.4, unit: "C")
    instruction_1 = recipe.instructions.create(step: "put the squash in the ravioli")
    instruction_2 = recipe.instructions.create(step: "boil those lil guys")
    instruction_3 = recipe.instructions.create(step: "cover with some sauce and enjoy!")

    VCR.use_cassette "No Reviews" do
      visit dashboard_index_path
    end

    VCR.use_cassette "No Reviews" do
      click_on recipe.name
    end

    expect(current_path).to eq(restaurant_recipe_path(restaurant, recipe))
    expect(page).to have_content(squash.name)
    expect(page).to have_content(ravioli.name)
    expect(page).to have_content(amount_1.quantity)
    expect(page).to have_content(amount_1.unit)
    expect(page).to have_content(amount_2.quantity)
    expect(page).to have_content(amount_2.unit)
    expect(page).to have_content(instruction_1.step)
    expect(page).to have_content(instruction_2.step)
    expect(page).to have_content(instruction_3.step)
  end
end
