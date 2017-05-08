class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :title, null: false
      t.string :year, null: false
      t.integer :ranking, null: false, default: 0
      t.integer :kind, null: false, default: 0, index: true
      t.timestamps null: false
    end
  end
end
