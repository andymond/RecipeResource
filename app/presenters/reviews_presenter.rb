class ReviewsPresenter

  def initialize(restaurant)
    service = YelpReviewService.new
    @reviews = service.recent_reviews(restaurant)
  end

  def url(number)
    reviews[number][:url] unless reviews.nil?
  end

  def text(number)
    reviews[number][:text] unless reviews.nil?
  end

  def rating(number)
    reviews[number][:rating] unless reviews.nil?
  end

  def reviewer(number)
    reviews[number][:user][:name] unless reviews.nil?
  end

  def time(number)
    unless reviews.nil?
      t = Time.new(reviews[number][:time_created])
      t.strftime("%b %d %Y")
    end
  end


  private
    attr_reader :reviews

end
