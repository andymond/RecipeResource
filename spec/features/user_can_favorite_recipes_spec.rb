require "rails_helper"

describe "Any user" do
  it "can favorite an existing recipe", js: true do
    user   = create(:chef)
    recipe = user.restaurants.first.recipes.create(name: "cat food", station: "litter box")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette "No Reviews" do
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

  it "can view a list of all their favorite recipes", js: true do
    user     = create(:chef)
    recipe_1 = user.restaurants.first.recipes.create(name: "cat food", station: "litter box")
    recipe_2 = user.restaurants.first.recipes.create(name: "dog food", station: "litter box")
    recipe_3 = user.restaurants.first.recipes.create(name: "fish food", station: "litter box")
    user.favorites.create(recipe_id: recipe_1.id)
    user.favorites.create(recipe_id: recipe_2.id)
    user.favorites.create(recipe_id: recipe_3.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette "No Reviews" do
      visit root_path
    end

    find(".open-card").click

    VCR.use_cassette "No Reviews" do
      within ".user-card" do
        find(".link-to-favorites-index").click
      end
    end

    expect(current_path).to eq(user_favorites_path(user))
    expect(page).to have_content(recipe_1.name)
    expect(page).to have_content(recipe_2.name)
    expect(page).to have_content(recipe_3.name)
  end
end
