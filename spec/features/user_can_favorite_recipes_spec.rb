require "rails_helper"

describe "Any user" do
  it "can favorite an existing recipe" do
    user   = create(:chef)
    recipe = user.restaurants.first.recipes.create(name: "cat food", station: "litter box")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassete "No Reviews" do
      visit root_path
    end

    within ".cat-food" do
      find(".favorite").click
    end

    expect(user.recipes.first).to eq(recipe)

    within(".cat-food") do
      find(".favorite").click
    end

    expect(user.recipes.empty?).to be(true)
  end

  xit "can view a list of all their favorite recipes" do
    user   = create(:chef)
    recipe_1 = user.restaurants.first.recipes.create(name: "cat food", station: "litter box")
    recipe_2 = user.restaurants.first.recipes.create(name: "dog food", station: "litter box")
    recipe_3 = user.restaurants.first.recipes.create(name: "fish food", station: "litter box")
    user.favorites(recipe_id: recipe_1.id)
    user.favorites(recipe_id: recipe_2.id)
    user.favorites(recipe_id: recipe_3.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit user_favorites_path(user)

    expect(page).to have_content(recipe_1.name)
    expect(page).to have_content(recipe_2.name)
    expect(page).to have_content(recipe_3.name)

    within(".dog-food") do
      find(".favorite").click
    end

    expect(page).to_not have_content(recipe_2.name)
  end
end
