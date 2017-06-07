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

  describe('GET #new') do
    it('renders properly') do
      get(:new)
      expect(response).to have_http_status(200)
      expect(assigns(:meeting)).to be_a_new(Meeting)
    end
  end

  describe('GET #edit') do
    it('renders the edit meeting page') do
      meeting = create(:meeting)
      get(:edit, params: { id: meeting.to_param })
      expect(response).to have_http_status(200)
      expect(assigns(:meeting)).to eq(meeting)
    end
  end

  describe('POST #create') do
    it('valid parameters') do
      attributes = { title: 'S18', year: '2017', kind: 'board', ranking: 0 }

      expect do
        post(:create, params: { meeting: attributes })
      end.to change(Meeting, :count).by(1)

      expect(response).to redirect_to(edit_meeting_path(Meeting.last))
    end

    it('invalid parameters') do
      attributes = { title: 'No year!' }

      expect do
        post(:create, params: { meeting: attributes })
      end.to change(Meeting, :count).by(0)

      expect(response).to have_http_status(422)
      expect(response).to render_template(:new)
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

    it('creates document') do
      meeting = create(:meeting)
      attributes = { document_kind: :minute, file_sv: test_file }

      expect do
        patch(:update, params: { id: meeting.to_param, meeting: attributes })
      end.to change(MeetingDocument, :count).by(1)
    end
  end

  describe('DELETE # destroy') do
    it 'destroys meeting' do
      meeting = create(:meeting)

      expect do
        delete(:destroy, params: { id: meeting.to_param })
      end.to change(Meeting, :count).by(-1)
      expect(response).to redirect_to(meetings_path)
    end
  end

  def test_file
    Rack::Test::UploadedFile.new(File.open('spec/support/file.pdf'))
  end
end
