class AddCarrierwaveToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column(:users, :avatar, :string)
    remove_column(:users, :profile_image_thumb_uid, :string)
  end
end
