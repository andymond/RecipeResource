require "rails_helper"

describe User, type: :model do
  describe "relationships" do
    it {should have_one(:app_credential)}
    it {should have_one(:google_credential)}
    it {should have_many(:user_roles)}
    it {should have_many(:roles)}
    it {should have_many(:restaurants)}
  end

  describe "oauth" do
    it "creates or updates itself from oauth hash" do
      auth = {
        provider: "google",
          uid: "12345678910",
          info: {
            email: "test@email.com",
            first_name: "testy",
            last_name: "mctesterson",
            image: "fake_url"
          },
          credentials: {
            token: "abcdefg12345",
            refresh_token: "12345abcdefg",
            expires_at: DateTime.now,
          }
        }

      user = User.update_or_create(auth)

      expect(user.google_credential.provider).to eq("google")
      expect(user.google_credential.uid).to eq("12345678910")
      expect(user.email).to eq("test@email.com")
      expect(user.first_name).to eq("testy")
      expect(user.last_name).to eq("mctesterson")
      expect(user.image_url).to eq("fake_url")
      expect(user.google_credential.token).to eq("abcdefg12345")
      expect(user.google_credential.refresh_token).to eq("12345abcdefg")
      expect(user.google_credential.oauth_expires_at).to eq(auth[:credentials][:expires_at])
    end
  end
end
