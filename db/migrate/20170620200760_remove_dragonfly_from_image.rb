class RemoveDragonflyFromImage < ActiveRecord::Migration[5.0]
  def change
    remove_column(:images, :image_uid, :string)
    remove_column(:images, :image_name, :string)
  end
end
