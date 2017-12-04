class AddDescriptionToPosition < ActiveRecord::Migration[5.0]
  def change
    add_column :positions, :desc_sv, :text
    add_column :positions, :desc_en, :text
  end
end
