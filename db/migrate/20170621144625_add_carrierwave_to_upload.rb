class AddCarrierwaveToUpload < ActiveRecord::Migration[5.0]
  def change
    add_column(:uploads, :pdf, :string)
    remove_column(:uploads, :image_id, :integer)
    change_column_null(:uploads, :file_uid, true)
  end
end
