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

  describe "GET # show" do
    it "redirects to image" do
      image = create(:image)
      allow_any_instance_of(Image).to \
        receive(:url).and_return('localhost:3000/good_url')
      get(:show, params: { id: image.to_param })
      expect(response).to redirect_to('localhost:3000/good_url')
    end
  end

  describe "GET edit" do
    it "render edit " do
      image = create(:image)
      get(:edit, params: { id: image.to_param })
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
        file: test_file
      }

      expect do
        post(:create, params: { image: attributes })
      end.to change(Image, :count).by(1)

      created = Image.last
      expect(response).to redirect_to(images_path)
      expect(response).to have_http_status(302)
      expect(created.tags.map(&:id)).to include(tag.id)
      expect(flash[:notice]).to eq(I18n.t('images.create.success'))
    end

    it 'invalid parameters' do
      attributes = { file: nil }

      expect do
        post(:create, params: { image: attributes })
      end.to change(Image, :count).by(0)

      expect(response).to render_template(:new)
      expect(response).to have_http_status(422)
    end

    it 'sets tags when creating remotely' do
      tag = create(:tag)
      attributes = {
        title: 'Svensk',
        tag_ids: [tag.id],
        file: test_file
      }

      expect do
        post(:create, xhr: true, params: { image: attributes })
      end.to change(Image, :count).by(1)

      created = Image.last
      expect(response).to render_template('upload_success')
      expect(created.tags.map(&:id)).to include(tag.id)
      expect(assigns(:tags)).to_not be_nil
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

      patch(:update, params: { id: resource.id, image: attributes })
      resource.reload
      expect(response).to redirect_to(edit_image_path(resource))
      expect(response).to have_http_status(302)
      expect(resource.title).to eq("Ny")
      expect(resource.tags.map(&:id)).to include(tag.id)
    end

    it "invalid params" do
      resource = create(:image, title: "Gammal")
      attributes = { file: nil }

      patch(:update, params: { id: resource.id, image: attributes })
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
        delete(:destroy, params: { id: image.to_param })
      end.to change(Image, :count).by(-1)

      expect(response).to redirect_to(images_path)
    end
  end

  def test_file
    Rack::Test::UploadedFile.new(File.open('spec/support/image.png'))
  end
end
