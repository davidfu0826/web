class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :taggable, polymorphic: true
      t.references :tags
      t.timestamps
    end
  end
end
