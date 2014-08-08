class CreatePagesUsers < ActiveRecord::Migration
  def change
    create_table :pages_users do |t|
      t.belongs_to :page
      t.belongs_to :user

      t.timestamps
    end
  end
end
