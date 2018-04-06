FactoryBot.define do
  factory :user do
    sequence :first_name { |n| "first_name#{n}"}
    sequence :last_name { |n| "last_name#{n}"}
    sequence :email { |n| "email#{n}@email.com"}
    before(:create) do |user|
      user.create_app_credential(password: "password")
    end
  end

end
