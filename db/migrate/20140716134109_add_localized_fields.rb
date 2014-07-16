class AddLocalizedFields < ActiveRecord::Migration
  def change
    #Add Localization fields
    change_table :pages do |t|
      t.rename :title, :title_sv
      t.rename :content, :content_sv

      t.string :title_en
      t.text :content_en
    end

    change_table :posts do |t|
      t.rename :title, :title_sv
      t.rename :content, :content_sv

      t.string :title_en
      t.text :content_en
    end

    change_table :events do |t|
      t.rename :title, :title_sv
      t.rename :description, :description_sv

      t.string :title_en
      t.string :description_en
    end

    change_table :event_groups do |t|
      t.rename :name, :name_sv

      t.string :name_en
    end

    change_table :nav_items do |t|
      t.rename :title, :title_sv

      t.string :title_en
    end

    change_table :users do |t|
      t.rename :title, :title_sv

      t.string :title_en
    end
  end
end
