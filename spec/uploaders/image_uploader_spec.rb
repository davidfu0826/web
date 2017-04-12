require 'rails_helper'
require 'carrierwave/test/matchers'

RSpec.describe ImageUploader do
  include CarrierWave::Test::Matchers
  let(:image) { create(:image) }
  let(:uploader) { ImageUploader.new(image, :file) }

  before do
    ImageUploader.enable_processing = true

    File.open('spec/support/image.png') do |f|
      uploader.store!(f)
    end end
  after do
    ImageUploader.enable_processing = false
    uploader.remove!
  end

  context 'the thumb version' do
    it 'should scale down a landscape image to be exactly 350 by 350 pixels' do
      expect(uploader.thumb).to have_dimensions(350, 350)
    end
  end

  context 'the small version' do
    it 'should scale down a landscape image to fit within 1680 by 10000 pixels' do
      expect(uploader.large).to be_no_larger_than(1680, 10_000)
    end
  end
end
