class ChangeUserImageDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :users, :image_url, "default-profile.png"
  end
end
