class YelpReviewService

  def initialize
    @conn = Faraday.new("https://api.yelp.com")
  end

  def recent_reviews(restaurant)
    response = conn.get do |req|
      req.url "/v3/businesses/#{restaurant.yid}/reviews"
      req.headers["Authorization"] = "Bearer #{ENV['YELP_API_KEY']}"
    end
    JSON.parse(response.body, symbolize_names: true)[:reviews]
  end

  private
    attr_reader :conn

end
