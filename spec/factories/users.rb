FactoryBot.define do
  factory :user do
    sequence :first_name { |n| "first_name#{n}"}
    sequence :last_name { |n| "last_name#{n}"}
    sequence :email { |n| "email#{n}@email.com"}
  end

  factory :app_credential do
    password "password"
    user
  end

end
