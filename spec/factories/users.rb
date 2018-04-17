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

  factory :chef, class: User do
    sequence :first_name { |n| "first_name#{n}"}
    sequence :last_name { |n| "last_name#{n}"}
    sequence :email { |n| "email#{n}@email.com"}
    before(:create) do |user|
      user.create_app_credential(password: "password")
    end
    after(:create) do |user|
      VCR.use_cassette "Factory restaurant" do
        user.set_restaurant(name: "testaurant1", zipcode: 54321)
      end
    end
  end

  factory :chef_2, class: User do
    sequence :first_name { |n| "first_name2#{n}"}
    sequence :last_name { |n| "last_name2#{n}"}
    sequence :email { |n| "email2#{n}@email.com"}
    before(:create) do |user|
      user.create_app_credential(password: "password")
    end
    after(:create) do |user|
      VCR.use_cassette "Factory restaurant 2" do
        user.set_restaurant(name: "testaurant2", zipcode: 54321)
      end
    end
  end

  factory :cook, class: User do
    sequence :first_name { |n| "first_name#{n}"}
    sequence :last_name { |n| "last_name#{n}"}
    sequence :email { |n| "email#{n}@email.com"}
    before(:create) do |user|
      user.create_app_credential(password: "password")
    end
    after(:create) do |user|
      restaurant = Restaurant.create(name: "testaurant1", zipcode: 54321)
      user.cooks_at(restaurant)
    end
  end

end
