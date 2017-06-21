class CreateSabbaticalOfficers < ActiveRecord::Migration[5.0]
  def change
    create_table :sabbatical_officers do |t|
      t.string :description_en
      t.string :description_sv
      t.string :email, null: false
      t.string :image
      t.string :name, null: false
      t.string :phone, null: false
      t.integer :position
      t.string :role_en, null: false
      t.string :role_sv, null: false

      t.timestamps
    end
  end
end
