require "rails_helper"

describe YelpReviewService do
  let(:restaurant) { Restaurant.create(yid: "2ciJkwAoMAksdct4ABVv8w") }
  let(:service)    { YelpReviewService.new }

  it "returns 3 most recent reviews of user's restaurant" do
    VCR.use_cassette "Yelp Reviews" do
      reviews = service.recent_reviews(restaurant)

      expect(reviews).to be_an Array
      expect(reviews[0][:text]).to eq("amazing food - crispy bass + Departure wings\n\nThis restaurant is great and is the only reason I would ever venture into Cherry creek.")
      expect(reviews[0][:rating]).to eq(5)
      expect(reviews[1][:text]).to eq("I wish I could give Departure 6 stars! I have been here 4 times in the past year, and it has been consistently excellent and one of my favorite restaurants...")
      expect(reviews[1][:rating]).to eq(5)
      expect(reviews[2][:text]).to eq("We just stopped by for brunch and the food was AMAZING!! The service was also wonderful. Our server, Shane had great energy and made our experience fun!...")
      expect(reviews[2][:rating]).to eq(5)
    end
  end
end
