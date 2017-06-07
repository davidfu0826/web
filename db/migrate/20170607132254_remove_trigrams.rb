class RemoveTrigrams < ActiveRecord::Migration[5.0]
  def change
    drop_table(:trigrams)
  end
end
