require 'rails_helper'

RSpec.describe Upload, type: :model do
  it 'has valid factory' do
    expect(build_stubbed(:upload)).to be_valid
  end

  it 'gives url to image, if present' do
    image = build_stubbed(:image)
    allow(image).to receive(:url).and_return('https://github.com')

    upload = build_stubbed(:upload)
    expect(upload.view).to_not eq('https://github.com')

    upload.image = image
    expect(upload.view).to eq('https://github.com')
  end
end
