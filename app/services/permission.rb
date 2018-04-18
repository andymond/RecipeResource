class Permission
  extend Forwardable

  attr_reader :user, :restaurant, :controller, :action

  def_delegators :user, :is_site_admin?,
                        :is_chef?,
                        :is_cook?

  def initialize(user, restaurant)
    @user = user || User.new
    @restaurant = restaurant
  end

  def allow?(controller, action)
    @controller, @action = controller, action
    case
    when is_site_admin?
      platform_admin_permissions
    when is_chef?
      chef_permissions
    when is_cook?
      cook_permissions
    else
      visitor_permissions
    end
  end

  private

  def platform_admin_permissions
    return true
  end

  def chef_permissions
    user.restaurants.include?(restaurant)
  end

  def cook_permissions
    return true if controller == "users" && action == "edit"
    return true if controller == "restaurants" && action == "show"
    return true if controller == "welcome"
    return true if controller == "sessions"
    return true if controller == "gsessions"
    return true if controller == "google_users"
    return true if controller == "recipes" && action.in?(%w(index show))
    return true if controller == "recipe_images"
    return true if controller == "comments"
    return true if controller == "dashboard"
    return true if controller == "favorites"
  end

  def visitor_permissions
    return true if controller == "welcome"
    return true if controller == "dashboard"
    return true if controller == "sessions"
    return true if controller == "gsessions"
    return true if controller == "restaurants" && action.in?(%w(new create))
    return true if controller == "google_users"
    return true if controller == "users" && action.in?(%w(new create))
  end

end
