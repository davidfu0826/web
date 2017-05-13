class AddDateToMeeting < ActiveRecord::Migration
  def change
    add_column(:meetings, :meeting_date, :date)
  end
end
