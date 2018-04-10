FactoryBot.define do
  factory :user do
    sequence :first_name { |n| "first_name#{n}"}
    sequence :last_name { |n| "last_name#{n}"}
    sequence :email { |n| "email#{n}@email.com"}
    before(:create) do |user|
      user.create_app_credential(password: "password")
    end
  end

  factory :google_user, class: User do
    sequence :first_name { |n| "first_name#{n}"}
    sequence :last_name { |n| "last_name#{n}"}
    sequence :email { |n| "email#{n}@email.com"}
    before(:create) do |user|
      user.create_google_credential(provider: "google",
                                    uid: "12345678910",
                                    token: "abcdefg12345",
                                    refresh_token: "12345abcdefg",
                                    oauth_expires_at: DateTime.now
                                    )
    end
  end

end
