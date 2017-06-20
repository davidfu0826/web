class AddImageReferenceToUpload < ActiveRecord::Migration
  def change
    add_column(:uploads, :image_id, :integer, index: true)
  end
end
