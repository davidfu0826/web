class AddTypeToNavItems < ActiveRecord::Migration
  def change
    add_column :nav_items, :nav_item_type, :integer, null: false, default: 0
  end
end
