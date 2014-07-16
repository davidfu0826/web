class CreateEventGroup < ActiveRecord::Migration
  def change
    create_table :event_groups do |t|
      t.string :name
    end

    add_reference :events, :event_group, index: true
  end
end
