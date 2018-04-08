class ReviewsPresenter

  def initialize(restaurant)
    service = YelpReviewService.new
    @reviews = service.recent_reviews(restaurant)
  end

  def url(number)
    reviews[number][:url]
  end

  def text(number)
    reviews[number][:text]
  end

  def rating(number)
    reviews[number][:rating]
  end

  def reviewer(number)
    reviews[number][:user][:name]
  end

  def time(number)
    t = Time.new(reviews[number][:time_created])
    t.strftime("%b %d %Y")
  end


  private
    attr_reader :reviews

end
