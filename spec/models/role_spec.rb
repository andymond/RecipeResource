require "rails_helper"

describe Role do
  it { should have_many(:user_roles) }
  it { should have_many(:users) }
  it { should have_many(:restaurants) }
end
