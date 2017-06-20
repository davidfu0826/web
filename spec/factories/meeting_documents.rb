FactoryGirl.define do
  factory :meeting_document do
    meeting
    file_sv Rack::Test::UploadedFile.new(File.open('spec/support/file.pdf'))
    file_en Rack::Test::UploadedFile.new(File.open('spec/support/file.pdf'))
    kind { MeetingDocument.kinds.keys.sample }
  end
end
