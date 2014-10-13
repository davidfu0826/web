class RemoveDescriptionFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :description, :string
  end
end
