require "rails_helper"

describe "visitor visits root" do
  it "displays links to About and login/register options" do
    visit root_path

    expect(page).to have_content("About")
    expect(page).to have_content("Register")
    expect(page).to have_content("Log in")
  end

  it "displays register form to user on click" do
    visit root_path

    within(".register") do
      expect(page).to have_css('.hidden form', visible: false)
    end

    find(".register").click

    within(".register") do
      expect(page).to have_css('.hidden form', visible: true)
    end

    find(".register").click

    within(".register") do
      expect(page).to have_css('.hidden form', visible: false)
    end
  end

  it "displays login form to user on click" do
    visit root_path

    within(".login") do
      expect(page).to have_css('.hidden form', visible: false)
    end

    find(".login").click

    within(".login") do
      expect(page).to have_css('.hidden form', visible: true)
    end

    find(".login").click

    within(".login") do
      expect(page).to have_css('.hidden form', visible: false)
    end
  end
end
