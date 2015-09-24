class AddDatabaseIndexes < ActiveRecord::Migration
  def change
    add_index :contact_forms, :page_id
    add_index :contact_forms, :user_id
    add_index :nav_items, :page_id
    add_index :nav_items, :parent_id
    add_index :pages_users, :page_id
    add_index :pages_users, :user_id
    add_index :questions, :contact_form_id
    add_index :taggings, [:tag_id, :taggable_type]
    add_index :taggings, :tag_id
  end
end
