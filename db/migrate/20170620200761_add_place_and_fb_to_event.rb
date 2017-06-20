class AddPlaceAndFbToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column(:events, :place, :string)
    add_column(:events, :facebook, :string)
  end
end
