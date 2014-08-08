class DeleteEventGroups < ActiveRecord::Migration
  def change
    drop_table :event_groups
  end
end
