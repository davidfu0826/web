# Connects a Document to a Meeting
class MeetingDocument < ActiveRecord::Base
  belongs_to :document, required: true, dependent: :destroy
  belongs_to :meeting, required: true
  validates :kind, presence: true
  enum kind: { agenda: 0, convocation: 1, meeting_document: 2,
               minute: 3, summary: 4, other: 5 }
end
