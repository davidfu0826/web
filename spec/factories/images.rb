FactoryGirl.define do
  factory :image do
    file Rack::Test::UploadedFile.new(File.open('spec/support/cover.jpg'))
  end
end
