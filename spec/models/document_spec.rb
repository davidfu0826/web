require 'rails_helper'

RSpec.describe(Document, type: :model) do
  it 'has a valid factory' do
    expect(build_stubbed(:document)).to be_valid
  end

  describe 'file method' do
    it 'returns file based on locale' do
      document = build_stubbed(:document)
      document.locale = :en
      expect(document.file).to eq(document.file_en)
      document.locale = :sv
      expect(document.file).to eq(document.file_sv)
    end
  end
end
