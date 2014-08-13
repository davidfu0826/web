class RemoveDescriptionFromImage < ActiveRecord::Migration
  def change
    remove_column :images, :description
  end
end
