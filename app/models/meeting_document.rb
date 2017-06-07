# Connects a Document to a Meeting
class MeetingDocument < ApplicationRecord
  belongs_to :document, dependent: :destroy
  belongs_to :meeting
  validates :kind, presence: true
  enum kind: { convocation: 10, agenda: 12, meeting_document: 14,
               late_meeting_documents: 16, minute: 18, summary: 20, other: 22 }
end
