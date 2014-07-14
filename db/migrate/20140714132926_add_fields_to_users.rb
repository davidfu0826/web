class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :phonenumber, :string
    add_column :users, :title, :string
  end
end
