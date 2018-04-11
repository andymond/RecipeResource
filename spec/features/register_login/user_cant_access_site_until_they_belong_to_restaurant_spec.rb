require "rails_helper"

describe "User creates account with invalid restaurant" do
  it "doesn't allow user to access site until they create or join a restaurant" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_index_path

    expect(current_path).to eq(new_restaurant_path)
    expect(page).to have_content("You don't belong to a restaurant yet!")
    expect(page).to have_css(".new-restaurant-form")
    expect(page).to have_button("Register")
    expect(page).to have_content("Or request to join a restaurant")
  end
end
