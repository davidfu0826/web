require 'rails_helper'

RSpec.describe Upload, type: :model do
  it 'has valid factory' do
    expect(build_stubbed(:upload)).to be_valid
  end
end
