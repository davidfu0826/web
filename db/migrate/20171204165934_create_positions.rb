class CreatePositions < ActiveRecord::Migration[5.0]
  def change
    create_table :positions do |t|
      t.string :title_sv
      t.string :title_en
      t.integer :number
      t.string :committee_sv
      t.string :committee_en
      t.string :term
      t.string :apply_url

      t.timestamps
    end
  end
end
