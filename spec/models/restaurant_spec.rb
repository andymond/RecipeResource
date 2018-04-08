require "rails_helper"

describe Restaurant do
  it {should have_many(:user_roles)}
  it {should have_many(:roles)}
  it {should have_many(:users)}
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:zipcode)}
  it {should validate_uniqueness_of(:name).scoped_to(:zipcode)}
end
