class RemoveDragonfly < ActiveRecord::Migration[5.0]
  def change
    remove_column(:uploads, :file_uid, :string)
    remove_column(:users, :profile_image_uid, :string)
  end
end
