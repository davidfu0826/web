class AddPositionToNavItem < ActiveRecord::Migration
  def change
    add_column :nav_items, :position, :integer
  end
end
