class CreateMeetingDocuments < ActiveRecord::Migration
  def change
    create_table :meeting_documents do |t|
      t.references :meeting, null: false, foreign_key: true, index: true
      t.references :document, null: false, foreign_key: true, index: true
      t.integer :kind, null: false, default: 0, index: true
      t.timestamps null: false
    end
  end
end
