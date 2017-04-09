require 'rails_helper'

RSpec.describe ImagesController, type: :controller do
  allow_user_to(:manage, Image)

  describe "GET#new" do
    it "renders properly" do
      get :new
      expect(response).to render_template :new
      expect(response).to have_http_status(200)
      expect(assigns(:image)).to be_a_new(Image)
    end
  end

  describe 'GET #index' do
    it 'renders properly' do
      first = create(:image)
      second = create(:image)
      third = create(:image)

      get(:index)
      expect(response).to have_http_status(200)
      expect(assigns(:images).to_a).to eq([first, second, third])
    end
  end

  describe "GET edit" do
    it "render edit " do
      image = create(:image)
      get :edit, id: image.to_param
      expect(response).to render_template :edit
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    it "valid params" do
      tag = create(:tag)
      attributes = {
        title: 'Svensk',
        tag_ids: [tag.id],
        image: test_file
      }

      expect do
        post :create, image: attributes
      end.to change(Image, :count).by(1)

      created = Image.last
      expect(response).to redirect_to(images_path)
      expect(response).to have_http_status(302)
      expect(created.tags.map(&:id)).to include(tag.id)
      expect(flash[:notice]).to eq(I18n.t('images.create.success'))
    end

    it 'invalid parameters' do
      attributes = { image: nil }

      expect do
        post(:create, image: attributes)
      end.to change(Image, :count).by(0)

      expect(response).to render_template(:new)
      expect(response).to have_http_status(422)
    end
  end

  describe "patch#update" do
    it "valid params" do
      tag = create(:tag)
      resource = create(:image, title: "Gammal")

      attributes = {
        title: "Ny",
        tag_ids: [tag.id]
      }

      patch :update, id: resource.id, image: attributes
      resource.reload
      expect(response).to redirect_to(edit_image_path(resource))
      expect(response).to have_http_status(302)
      expect(resource.title).to eq("Ny")
      expect(resource.tags.map(&:id)).to include(tag.id)
    end

    it "invalid params" do
      resource = create(:image, title: "Gammal")
      attributes = { image: nil }

      patch :update, id: resource.id, image: attributes
      resource.reload
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(422)
      expect(resource.title).to eq("Gammal")
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys upload' do
      image = create(:image)

      expect do
        delete(:destroy, id: image.to_param)
      end.to change(Image, :count).by(-1)

      expect(response).to redirect_to(images_path)
    end
  end

  def test_file
    Rack::Test::UploadedFile.new(File.open('spec/support/image.png'))
  end
end
