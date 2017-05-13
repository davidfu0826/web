class AddMeetingToDocument < ActiveRecord::Migration
  def change
    add_reference(:documents, :meeting, foreign_key: true)
    remove_column(:documents, :revision_date, :date)
  end
end
