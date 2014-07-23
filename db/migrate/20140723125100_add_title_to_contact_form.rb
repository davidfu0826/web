class AddTitleToContactForm < ActiveRecord::Migration
  def change
    add_column :contact_forms, :title, :string
  end
end
