class UserNotifier < ApplicationMailer

  def invite(restaurant, role, email)
    @restaurant = restaurant
    @url        = "#{ENV['ROOT']}/users/new?role=#{role}&restaurant=#{restaurant.slug}"
    mail(to: email, subject: "You've been invited to #{restaurant.name}")
  end

end
