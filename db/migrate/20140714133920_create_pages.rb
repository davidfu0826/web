class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :content
      t.string :slug # should be unique

      t.timestamps
    end
  end
end
