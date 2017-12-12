class AddKindToPosition < ActiveRecord::Migration[5.0]
  def change
    add_column :positions, :kind, :integer, null: false, default: 0, index: true
  end
end
