FactoryGirl.define do
  factory(:document) do
    title_sv
    title_en
    description_sv { generate(:content_sv) }
    description_en { generate(:content_en) }
    category { Document.categories.keys.sample }
    file_sv Rack::Test::UploadedFile.new(File.open('spec/support/file.pdf'))
    file_en Rack::Test::UploadedFile.new(File.open('spec/support/file.pdf'))
    revision_date { rand(6).days.ago }
  end
end
