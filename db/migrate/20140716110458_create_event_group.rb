class CreateEventGroup < ActiveRecord::Migration
  def change
    create_table :event_groups do |t|
      t.string :name
    end
  end
end
