class YelpSearchService

  def initialize
    @conn = Faraday.new("https://api.yelp.com")
  end

  def update_restaurant(restaurant)
    response = conn.get do |req|
      req.url "/v3/businesses/search", term: restaurant.name, location: restaurant.zipcode, category: "restaurants"
      req.headers["Authorization"] = "Bearer #{ENV['YELP_API_KEY']}"
    end
    match = parse_matches(response.body)
    set_restaurant_info(match)
  end

  private
    attr_reader :conn

    def parse_matches(matches)
      matches = JSON.parse(matches, symbolize_names: true)
      matches[:businesses].first
    end

    def set_restaurant_info(info)
      restaurant = Restaurant.find_by(name: info[:name], zipcode: info[:location][:zip_code])
      restaurant.update( yid: info[:id],
                         address: info[:location][:display_address].join("\n"),
                         image_url: info[:image_url],
                         rating: info[:rating],
                         phone_number: info[:display_phone],
                         yelp_url: info[:url].split("?")[0])
      restaurant
    end
end
