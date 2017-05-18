require 'rails_helper'

RSpec.describe(StaticPagesController, type: :controller) do
  allow_user_to :manage, :static_pages

  describe('GET # robots') do
    it('renders robots as txt') do
      get(:robots, format: :txt)
      expect(response).to render_template('robots')
    end
  end

  describe('GET # board') do
    it('renders proper meeting documents') do
      meeting = create(:meeting, kind: :board)
      create(:meeting_document,
             kind: :convocation,
             meeting: meeting,
             document: create(:document, file_en: nil))
      create(:meeting_document,
             kind: :agenda,
             meeting: meeting,
             document: create(:document, file_sv: nil))

      allow(I18n).to receive(:locale).and_return(:sv)
      get(:board)
      m = assigns(:meetings).first.second.first
      expect(m.meeting_documents.map(&:kind)).to eq(['convocation'])

      allow(I18n).to receive(:locale).and_return(:en)
      get(:board)
      m = assigns(:meetings).first.second.first
      expect(m.meeting_documents.map(&:kind)).to eq(['agenda'])
    end
  end
end
