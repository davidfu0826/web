class CreateNavItems < ActiveRecord::Migration
  def change
    create_table :nav_items do |t|
      t.string :title
      t.belongs_to :page
      t.references :parent
      t.timestamps
    end
  end
end
