require "rails_helper"

def stub_omniauth
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
    provider: "google",
      uid: "12345678910",
      info: {
        email: "test@email.com",
        first_name: "testy",
        last_name: "mctesterson",
        image: "default-profile.png"
      },
      credentials: {
        token: "abcdefg12345",
        refresh_token: "12345abcdefg",
        expires_at: DateTime.now,
      }
    })
end

describe "Google Oauth" do
  it "allows user to register with google oauth2" do
    stub_omniauth
    visit root_path

    VCR.use_cassette "Yelp Search" do
      within ".register-form" do
        within ".google-register form" do
          fill_in "restaurant", with: "Departure"
          fill_in "restaurant_zip", with: "80206"
          find('.google-oauth').click
        end
      end
    end

    VCR.use_cassette "Yelp Reviews" do
      find(".open-card").click
    end

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("Successfully registered with Google")
    expect(page).to have_content("Departure")
    expect(page).to have_link("Logout")
  end

  it "allows user to register with google oauth2" do
    stub_omniauth
    visit root_path

    VCR.use_cassette "Yelp Search" do
      within ".login-form" do
        find('.google-oauth').click
      end
    end

    VCR.use_cassette "Yelp Reviews" do
      find(".open-card").click
    end

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("Successfully registered with Google")
    expect(page).to have_content("Departure")
    expect(page).to have_link("Logout")
  end
end
