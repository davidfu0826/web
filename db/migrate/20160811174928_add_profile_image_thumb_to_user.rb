class AddProfileImageThumbToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile_image_thumb_uid, :string
  end
end
