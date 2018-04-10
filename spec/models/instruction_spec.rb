require "rails_helper"

describe Instruction do
  describe "relationships" do
    it {should belong_to(:recipe)}
  end
end
