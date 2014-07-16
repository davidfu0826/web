class ChangeAdminFieldToInteger < ActiveRecord::Migration
  def change
    remove_column :users, :admin
    add_column :users, :role, :integer
  end
end
