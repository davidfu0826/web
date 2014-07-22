class CreateContactForms < ActiveRecord::Migration
  def change
    create_table :contact_forms do |t|
      t.belongs_to :page
      t.belongs_to :user
      t.timestamps
    end
  end
end
