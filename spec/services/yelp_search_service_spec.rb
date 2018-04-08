require "rails_helper"

describe YelpSearchService do
  let(:restaurant_info) { Restaurant.create(name: "Departure", zipcode: "80206") }
  let(:service) { YelpSearchService.new}

  it "finds restaurant with name & zipcode" do
    VCR.use_cassette "Yelp Search" do
      restaurant = service.update_restaurant(restaurant_info)

      expect(restaurant).to be_a Restaurant
      expect(restaurant.yid).to eq("2ciJkwAoMAksdct4ABVv8w")
      expect(restaurant.name).to eq("Departure")
      expect(restaurant.address).to eq("249 Columbine St\nDenver, CO 80206")
      expect(restaurant.image_url).to eq("https://s3-media2.fl.yelpcdn.com/bphoto/aX6PLadesELMaiqOetw7BQ/o.jpg")
      expect(restaurant.rating).to eq("3.5")
      expect(restaurant.phone_number).to eq("(720) 772-5020")
      expect(restaurant.yelp_url).to eq("https://www.yelp.com/biz/departure-denver-3")
    end
  end
end
