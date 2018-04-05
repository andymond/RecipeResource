require "rails_helper"

describe User, type: :model do
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

    expect(user.provider).to eq("google")
    expect(user.uid).to eq("12345678910")
    expect(user.email).to eq("test@email.com")
    expect(user.first_name).to eq("testy")
    expect(user.last_name).to eq("mctesterson")
    expect(user.image_url).to eq("fake_url")
    expect(user.token).to eq("abcdefg12345")
    expect(user.refresh_token).to eq("12345abcdefg")
    expect(user.oauth_expires_at).to eq(auth[:credentials][:expires_at])
  end
end
