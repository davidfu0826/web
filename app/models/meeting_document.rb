# Connects a Document to a Meeting
class MeetingDocument < ActiveRecord::Base
  belongs_to :document, required: true, dependent: :destroy
  belongs_to :meeting, required: true
  validates :kind, presence: true
  enum kind: { minute: 0, convocation: 1, meeting_document: 2,
               agenda: 3, other: 3 }
end
