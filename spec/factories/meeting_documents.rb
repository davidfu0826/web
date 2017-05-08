FactoryGirl.define do
  factory :meeting_document do
    meeting
    document
    kind { MeetingDocument.kinds.keys.sample }
  end
end
