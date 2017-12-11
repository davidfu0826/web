FactoryBot.define do
  sequence(:content_en) {|n| "Some english contenet\n, number #{n}"}
  sequence(:content_sv) {|n| "Lite svenskt innehåll\n, nummer #{n}"}
  sequence(:link) {|n| "https://tlth.se/url#{n}"}
  sequence(:slug) {|n| "slug#{n}"}
  sequence(:title_en) {|n| "Title number #{n}"}
  sequence(:title_sv) {|n| "Titel nr #{n}"}
  sequence(:email) {|n| "u#{n}@tlth.se"}
  sequence(:name) {|n| "Namn #{n} Efternamn"}
  sequence(:phonenumber) {|n| "070#{n}6122"}
  sequence(:image_file) { |_| Rack::Test::UploadedFile.new(File.open('spec/support/cover.jpg')) }
  sequence(:pdf_file) { |_| Rack::Test::UploadedFile.new(File.open('spec/support/file.pdf')) }
end
