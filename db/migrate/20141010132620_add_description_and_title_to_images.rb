class AddDescriptionAndTitleToImages < ActiveRecord::Migration
  def change
    add_column :images, :title, :string
    add_column :images, :description, :string
  end
end
