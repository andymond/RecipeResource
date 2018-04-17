require "rails_helper"

describe UserNotifier, type: :mailer do
  it "#invite" do
    user = create(:chef)
    email = UserNotifier.invite(user.restaurants.first, "test@testmail.com")

    email.deliver_now

    expect(email.from).to eq(['donotreply@reciperesource.com'])
    expect(email.to).to eq(["test@testmail.com"])
    expect(email.subject).to eq("You've been invited to #{user.restaurants.first.name}")
    expect(email.body.encoded).to include("You&#39;ve been invited to join #{user.restaurants.first.name}")
    expect(email.body.encoded).to include("Click this link to join")
  end
end
