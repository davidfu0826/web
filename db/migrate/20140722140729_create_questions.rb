class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content
      t.belongs_to :contact_form

      t.timestamps
    end
  end
end
