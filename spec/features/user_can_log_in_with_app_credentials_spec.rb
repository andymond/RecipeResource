require "rails_helper"

describe "User logs in with app credentials" do
  let(:ac)   { create(:app_credential) }
  let(:user) { ac.user }

  it "allows user to log in with correct credentials" do
    visit root_path

    within(".login-form") do
      fill_in "login_email", with: user.email
      fill_in "login_password", with: user.app_credential.password
      click_on "Log in"
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
