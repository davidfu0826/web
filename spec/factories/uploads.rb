FactoryGirl.define do
  factory :upload do
    pdf Rack::Test::UploadedFile.new(File.open('spec/support/file.pdf'))
  end
end
