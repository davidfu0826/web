require 'rails_helper'

RSpec.describe(MeetingsController) do
  allow_user_to(:manage, Meeting)

  describe('GET #index') do
    it('renders properly') do
      create(:meeting, kind: :council, year: '2017', title: 'FM 7', ranking: 7)
      create(:meeting, kind: :council, year: '2017', title: 'FM 5', ranking: 5)
      get(:index)
      expect(response).to have_http_status(200)
      meetings = []
      assigns(:meetings).each do |_, ms|
        ms.each do |m|
          meetings << m.to_s
        end
      end
      expect(meetings).to eq(['2017 FM 7', '2017 FM 5'])
    end
  end

  describe('PATCH #update') do
    it('valid parameters') do
      meeting = create(:meeting, title: 'S5')
      attributes = { title: 'S7' }

      patch(:update, params: { id: meeting.to_param, meeting: attributes })
      meeting.reload
      expect(response).to redirect_to(edit_meeting_path(meeting))
      expect(meeting.title).to eq('S7')
    end

    it('invalid parameters') do
      meeting = create(:meeting, title: 'S9')
      attributes = { title: nil }

      patch(:update, params: { id: meeting.to_param, meeting: attributes })

      expect(response).to have_http_status(422)
      expect(response).to render_template(:edit)
      meeting.reload
      expect(meeting.title).to eq('S9')
    end
  end
end
