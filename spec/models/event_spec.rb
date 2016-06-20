require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'has a valid factory' do
    expect(build_stubbed(:event)).to be_valid
  end
end
