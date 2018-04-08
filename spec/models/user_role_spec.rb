require "rails_helper"

describe UserRole do
  it { should belong_to(:user) }
  it { should belong_to(:role) }
  it { should belong_to(:restaurant) }
end
