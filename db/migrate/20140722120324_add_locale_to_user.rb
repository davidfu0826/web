class AddLocaleToUser < ActiveRecord::Migration
  def change
    add_column :users, :locale, :integer
  end
end
