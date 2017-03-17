require 'rails_helper'

RSpec.configure do |config|
  config.use_transactional_fixtures = false
end

RSpec.describe(DocumentsController) do
  allow_user_to(:manage, Document)

  describe('GET #index') do
    it('renders properly') do
      get(:index)
      expect(response).to have_http_status(200)
    end
  end

  describe('GET #show') do
    it('renders file') do
      document = create(:document)
      get(:show, id: document.to_param)
      expect(response).to redirect_to(document.view)
      expect(response).to have_http_status(302)
    end
  end

  describe('GET #new') do
    it('renders properly') do
      get(:new)
      expect(response).to have_http_status(200)
      expect(assigns(:document)).to be_a_new(Document)
    end
  end

  describe('GET #edit') do
    it('renders the edit document page') do
      document = create(:document)
      get(:edit, id: document.to_param)
      expect(response).to have_http_status(200)
      expect(assigns(:document)).to eq(document)
    end
  end

  describe('POST #create') do
    it('valid parameters') do
      attributes = { title_sv: 'Stadgar', title_en: 'By-laws',
                     description_sv: 'Detta är stadgarna',
                     description_en: 'This is the by-laws' }

      expect do
        post(:create, document: attributes)
      end.to change(Document, :count).by(1)

      expect(response).to redirect_to(edit_document_path(Document.last))
    end

    it('invalid parameters') do
      attributes = { title_sv: 'Stadgar',
                     description_en: 'This is the by-laws' }

      expect do
        post(:create, document: attributes)
      end.to change(Document, :count).by(0)

      expect(response).to have_http_status(422)
      expect(response).to render_template(:new)
    end
  end

  describe('PATCH #update') do
    it('valid parameters') do
      document = create(:document, title_sv: 'Stadgar')
      attributes = { title_sv: 'Reglemente' }

      post(:update, id: document.to_param, document: attributes)
      document.reload
      expect(response).to redirect_to(edit_document_path(document))
      expect(document.title_sv).to eq('Reglemente')
    end

    it('invalid parameters') do
      document = create(:document, title_sv: 'Stadgar')
      attributes = { title_sv: nil }

      post(:update, id: document.to_param, document: attributes)

      expect(response).to have_http_status(422)
      expect(response).to render_template(:edit)
      document.reload
      expect(document.title_sv).to eq('Stadgar')
    end
  end
end
