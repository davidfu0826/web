require 'rails_helper'

RSpec.describe Position, type: :model do
  it 'has a valid factory' do
    expect(build_stubbed(:position)).to be_valid
  end
end