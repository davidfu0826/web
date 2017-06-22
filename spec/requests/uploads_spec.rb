require 'rails_helper'

RSpec.describe('Uploads', type: :request) do
  let(:user) { create(:user, :admin) }

  it('creates a upload and redirects to the edit page') do
    sign_in(user)
    get(new_upload_path)
    expect(response).to render_template(:new)
    attributes = { files: [test_file, test_file, test_file] }

    post(uploads_path, params: { upload: attributes })

    expect(response).to redirect_to(uploads_path)
    follow_redirect!

    expect(response).to render_template(:index)
    expect(response.body).to include(t('uploads.create.success'))
    expect(response.body).to include('file-pdf')
  end

  it('renders new if trying to create with invalid attributes') do
    sign_in(user)
    get(new_upload_path)
    expect(response).to render_template(:new)
    attributes = { files: [test_file(img: true), nil, nil] }

    post(uploads_path, params: { upload: attributes })

    expect(response).to redirect_to(uploads_path)
    follow_redirect!
    expect(response.body).to include(t('uploads.create.some_failed'))
  end

  it('find upload on index page, show action redirects') do
    sign_in(user)
    upload = create(:upload)
    allow_any_instance_of(Upload).to \
      receive(:view).and_return('http://good-upload-url.not')

    get(uploads_path)
    expect(response).to render_template(:index)
    expect(response.body).to include(upload_path(upload))

    get(upload_path(upload))
    expect(response).to redirect_to('http://good-upload-url.not')
  end

  it('redirects visitor to source url when not signed in') do
    upload = create(:upload)
    allow_any_instance_of(Upload).to \
      receive(:view).and_return('http://good-upload-url.not')

    get(upload_path(upload))
    expect(response).to redirect_to('http://good-upload-url.not')
  end

  it('destroys upload and returns to index') do
    sign_in(user)
    upload = create(:upload)

    get(upload_path(upload))

    delete(upload_path(upload))
    expect(response).to redirect_to(uploads_path)
    follow_redirect!
    expect(response.body).to include(t('uploads.destroy.success'))
  end

  def test_file(img: false)
    if img
      Rack::Test::UploadedFile.new(File.open('spec/support/image.png'))
    else
      Rack::Test::UploadedFile.new(File.open('spec/support/file.pdf'))
    end
  end
end
