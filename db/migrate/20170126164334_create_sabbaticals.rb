class CreateSabbaticals < ActiveRecord::Migration
  def change
    create_table :sabbaticals do |t|
      t.string :name
      t.string :title
      t.string :description
      t.string :tel
      t.string :email
      t.string :img
      t.integer :order

      t.timestamps null: false
    end
  end
end
