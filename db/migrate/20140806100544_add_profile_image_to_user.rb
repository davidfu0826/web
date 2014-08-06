class AddProfileImageToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile_image_uid, :string
  end
end
