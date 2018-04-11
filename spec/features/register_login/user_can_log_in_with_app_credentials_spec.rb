require "rails_helper"

describe "User logs in with app credentials" do
  let(:user) { create(:user) }

  it "allows user to log in with correct credentials" do
    restaurant = create(:restaurant)
    role = Role.create(name: "chef")
    user.user_roles.create(user_id: user.id, restaurant_id: restaurant.id, role_id: role.id)

    visit root_path

    VCR.use_cassette "Yelp Reviews" do
      within(".login-form") do
        fill_in "login_email", with: user.email
        fill_in "login_password", with: user.app_credential.password
        click_on "Log in"
      end
    end

    expect(current_path).to eq(dashboard_index_path)
    find('.open-card').click
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
  end

  it "doesn't allow user to log in without password" do
    visit root_path

    within(".login-form") do
      fill_in "login_email", with: user.email
      click_on "Log in"
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Could not validate credentials")
  end

  it "doesn't allow user to log in with wrong password" do
    visit root_path

    within(".login-form") do
      fill_in "login_email", with: user.email
      fill_in "login_password", with: "sneaky_fake_password"
      click_on "Log in"
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Could not validate credentials")
  end
end
