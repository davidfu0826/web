class AddLinkToNavItem < ActiveRecord::Migration
  def change
    add_column :nav_items, :link, :string
  end
end
