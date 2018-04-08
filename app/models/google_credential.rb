class GoogleCredential < ApplicationRecord
  belongs_to :user

  def update_or_create(attrs)
    if user.nil?
      create_user(attrs)
    else
      user.update_attributes(attrs)
    end
    user
  end
end
