FactoryBot.define do
  factory :meeting_document do
    meeting
    file_sv { generate(:pdf_file) }
    file_en { generate(:pdf_file) }
    kind { MeetingDocument.kinds.keys.sample }
  end
end
