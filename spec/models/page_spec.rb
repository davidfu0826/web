require 'rails_helper'

RSpec.describe Page, type: :model do
  it 'has a valid factory' do
    expect(build_stubbed(:page)).to be_valid
  end

  describe 'validates' do
    it 'slug only lowercase' do
      page = build_stubbed(:page, slug: 'slug-slug-123')
      page.valid?
      expect(page.errors[:slug]).to be_empty

      page.slug = 'slug_SLUG123'
      page.valid?
      expect(page.errors[:slug]).to_not be_empty
    end
  end
end
