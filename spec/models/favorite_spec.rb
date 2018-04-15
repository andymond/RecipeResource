require 'rails_helper'

describe Favorite, type: :model do
  it {should belong_to(:user)}
  it {should belong_to(:recipe)}
end
