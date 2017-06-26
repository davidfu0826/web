require 'rails_helper'

RSpec.describe('Meetings and Documents', type: :request) do
  let(:admin) { create(:user, :admin) }

  it('creates a new meeting and redirects to edit page') do
    sign_in(admin)
    get(meetings_path)
    expect(response).to render_template(:index)

    get(new_meeting_path)
    expect(response).to render_template(:new)

    attributes = FactoryGirl.attributes_for(:meeting, title: 'MöteT')
    post(meetings_path, params: { meeting: attributes })

    expect(response).to redirect_to(edit_meeting_path(Meeting.last))
    follow_redirect!
    expect(response).to render_template(:edit)
    expect(response.body).to include(t('meetings.create.success'))
    expect(response.body).to include('MöteT')
  end

  it('renders new if trying to create with invalid attributes') do
    sign_in(admin)
    get(new_meeting_path)
    expect(response).to render_template(:new)
    attributes = { title: 'A meeting' }

    post(meetings_path, params: { meeting: attributes })

    expect(response).to render_template(:new)
    expect(response).to have_http_status(422)
  end

  it('adds a document to a meeting, updates and destroys it') do
    sign_in(admin)
    meeting = create(:meeting)
    get(edit_meeting_path(meeting))
    expect(response).to render_template(:edit)

    attributes = { document_kind: :minute,
                   file_sv: FactoryGirl.generate(:pdf_file) }
    patch(meeting_path(meeting), params: { meeting: attributes })

    expect(response).to redirect_to(edit_meeting_path(Meeting.last))
    follow_redirect!
    expect(response).to render_template(:edit)
    expect(response.body).to include(t('meetings.update.success'))
    expect(response.body).to include('file.pdf') # Rendered in file url

    meeting_document = MeetingDocument.last
    expect(meeting_document.minute?).to be_truthy

    patch(meeting_meeting_document_path(meeting, meeting_document),
          params: { meeting_document: { kind: :convocation } })
    expect(response).to redirect_to(edit_meeting_path(meeting, anchor: :document))
    follow_redirect!
    expect(response.body).to \
      include(t('meeting_documents.update.success',
                kind: t('model.meeting_document.kinds.convocation')))
    meeting_document.reload
    expect(meeting_document.convocation?).to be_truthy

    delete(meeting_meeting_document_path(meeting, meeting_document))
    expect(response).to redirect_to(edit_meeting_path(meeting))
    follow_redirect!
    expect(response.body).to include(t('meeting_documents.destroy.success'))
    expect(response.body).to_not include('file.pdf') # Rendered in file url
  end

  it('redirects visitor to source url when not signed in') do
    meeting_document = create(:meeting_document)
    allow_any_instance_of(MeetingDocument).to \
      receive(:view).and_return('http://good-meeting_document-url.not')

    get(meeting_document_path(meeting_document))
    expect(response).to redirect_to('http://good-meeting_document-url.not')
  end

  it('destroys meeting and returns to index') do
    sign_in(admin)
    meeting = create(:meeting)

    delete(meeting_path(meeting))
    expect(response).to redirect_to(meetings_path)
    follow_redirect!
    expect(response.body).to include(t('meetings.destroy.success'))
  end
end
