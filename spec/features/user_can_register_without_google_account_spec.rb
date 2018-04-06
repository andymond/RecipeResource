require "rails_helper"

describe "authentication" do
  it "allows user to register without google account" do
    visit root_path

    within('.register-form') do
      fill_in "first_name", with: "Test"
      fill_in "last_name", with: "McTesterson"
      fill_in "email", with: "test@email.com"
      fill_in "password", with: "password"
      fill_in "password_confirmation", with: "password"
      click_on "Register"
    end

    expect(current_path).to eq dashboard_index_path
    expect(page).to have_content("Account created!")

    find('.open-card').click
    expect(page).to have_content("Test McTesterson")
  end
  it "doesn't allow user to register without password & confirmation" do
    visit root_path

    within('.register-form') do
      fill_in "first_name", with: "Test"
      fill_in "last_name", with: "McTesterson"
      fill_in "email", with: "test@email.com"
      click_on "Register"
    end

    expect(current_path).to eq root_path
    expect(page).to have_content("Couldn't create account.")
  end

  it "doesn't allow user to register without confirmation" do
    visit root_path

    within('.register-form') do
      fill_in "first_name", with: "Test"
      fill_in "last_name", with: "McTesterson"
      fill_in "email", with: "test@email.com"
      fill_in "password", with: "password"
      click_on "Register"
    end

    expect(current_path).to eq root_path
    expect(page).to have_content("Couldn't create account.")
  end

  it "doesn't allow user to register without first name" do
    visit root_path

    within('.register-form') do
      fill_in "last_name", with: "McTesterson"
      fill_in "email", with: "test@email.com"
      fill_in "password", with: "password"
      fill_in "password_confirmation", with: "password"
      click_on "Register"
    end

    expect(current_path).to eq root_path
    expect(page).to have_content("Couldn't create account.")
  end

  it "doesn't allow user to register without last name" do
    visit root_path

    within('.register-form') do
      fill_in "last_name", with: "McTesterson"
      fill_in "email", with: "test@email.com"
      fill_in "password", with: "password"
      fill_in "password_confirmation", with: "password"
      click_on "Register"
    end

    expect(current_path).to eq root_path
    expect(page).to have_content("Couldn't create account.")
  end
end
