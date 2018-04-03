require "rspec_rails"

describe "visitor visits root" do
  it "displays links to About and login/register options" do
    visit root_path

    expect(page).to have_link("About")
    expect(page).to have_link("Register")
    expect(page).to have_link("Login")
  end
end
