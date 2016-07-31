require 'rails_helper'

RSpec.describe UploadsController, type: :controller do
  allow_user_to(:manage, Upload)

  describe 'GET #show' do
    it 'sends file' do
      upload = create(:upload)

      get(:show, id: upload.to_param)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #new' do
    it 'sets new upload and renders' do
      get(:new)

      expect(response).to have_http_status(200)
      expect(assigns(:upload)).to be_a_new(Upload)
    end
  end

  describe 'GET #index' do
    it 'renders properly' do
      first = create(:upload, updated_at: 25.minutes.from_now)
      third = create(:upload, updated_at: 10.minutes.from_now)
      second = create(:upload, updated_at: 15.minutes.from_now)

      get(:index)
      expect(response).to have_http_status(200)
      expect(assigns(:uploads)).to eq([first, second, third])
    end
  end

  describe 'POST #create' do
    it 'valid parameters' do
      attributes = { files: [test_file, test_file, test_file] }

      expect do
        post(:create, upload: attributes)
      end.to change(Upload, :count).by(3)

      expect(response).to redirect_to(uploads_path)
      expect(flash[:notice]).to eq(I18n.t('model.upload.success_uploading'))
    end

    it 'invalid parameters' do
      attributes = { files: [nil, nil, nil] }

      expect do
        post(:create, upload: attributes)
      end.to change(Upload, :count).by(0)

      expect(response).to redirect_to(uploads_path)
      expect(flash[:notice]).to include(I18n.t('model.upload.failed_to_save_some'))
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys upload' do
      upload = create(:upload)

      expect do
        delete(:destroy, id: upload.to_param)
      end.to change(Upload, :count).by(-1)

      expect(response).to redirect_to(uploads_path)
    end
  end


  def test_file
    Rack::Test::UploadedFile.new(File.open('spec/support/image.png'))
  end
end
