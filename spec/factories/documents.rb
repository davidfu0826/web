FactoryBot.define do
  factory(:document) do
    title_sv
    title_en
    description_sv { generate(:content_sv) }
    description_en { generate(:content_en) }
    category { Document.categories.keys.sample }
    file_sv { generate(:pdf_file) }
    file_en { generate(:pdf_file) }
    meeting
  end
end
