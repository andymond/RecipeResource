class UserNotifier < ApplicationMailer

  def invite(restaurant, email)
    @restaurant = restaurant
    @url        = "#{ENV['ROOT']}/users/new"
    mail(to: email, subject: "You've been invited to #{restaurant.name}")
  end

end
