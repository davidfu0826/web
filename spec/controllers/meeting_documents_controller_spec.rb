require 'rails_helper'

RSpec.describe(MeetingDocumentsController) do
  allow_user_to(:manage, Meeting)
  allow_user_to(:manage, MeetingDocument)

  describe('PATCH #update') do
    it('valid parameters') do
      meeting = create(:meeting)
      meeting_document = create(:meeting_document, meeting: meeting,
                                                   kind: :minute)
      attributes = { kind: :convocation }

      patch(:update, params: { id: meeting_document.to_param,
                               meeting_id: meeting.to_param,
                               meeting_document: attributes })
      meeting_document.reload
      expect(response).to redirect_to(edit_meeting_path(meeting,
                                                        anchor: :document))
      expect(meeting_document.kind).to eq(:convocation.to_s)
    end

    it('invalid parameters') do
      meeting = create(:meeting)
      meeting_document = create(:meeting_document, meeting: meeting,
                                                   kind: :minute)
      attributes = { kind: nil }

      patch(:update, params: { id: meeting_document.to_param,
                               meeting_id: meeting.to_param,
                               meeting_document: attributes })
      meeting_document.reload
      expect(response).to redirect_to(edit_meeting_path(meeting,
                                                        anchor: :document))
      expect(meeting_document.kind).to eq(:minute.to_s)
    end
  end

  describe('DELETE # destroy') do
    it 'destroys meeting_document' do
      meeting = create(:meeting)
      meeting_document = create(:meeting_document, meeting: meeting)

      expect do
        delete(:destroy, params: { meeting_id: meeting.to_param,
                                   id: meeting_document.to_param })
      end.to change(MeetingDocument, :count).by(-1)
      expect(response).to redirect_to(edit_meeting_path(meeting))
    end
  end
end
