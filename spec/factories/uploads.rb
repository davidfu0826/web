FactoryGirl.define do
  factory :upload do
    file Rack::Test::UploadedFile.new(File.open('spec/support/file.pdf'))
  end
end
