require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  allow_user_to :manage, Post

  describe "GET show" do
    it "render show " do
      post = create(:post)
      get :show, id: post.to_param
      expect(response).to render_template :show
      expect(response).to have_http_status(200)

    end
  end

  describe "GET#index" do
    it "renders properly" do
      3.times { create(:post) }
      get :index
      expect(response).to render_template :index
      expect(response).to have_http_status(200)
    end
  end

  describe "GET#new" do
    it "renders properly" do
      get :new
      expect(response).to render_template :new
      expect(response).to have_http_status(200)
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "POST#create" do
    it "valid params" do
      image = create(:image)
      tag = create(:tag)
      attributes = {
        title_sv: 'Svensk', content_sv: 'Ett svenskt inlägg',
        title_en: 'English', content_en: 'An English post',
        image_id: image.id, tag_ids: [tag.id]
      }

      expect do
        post :create, post: attributes
      end.to change(Post, :count).by(1)
      created = Post.last
      expect(response).to redirect_to(edit_post_path(created))
      expect(response).to have_http_status(302)
      expect(created.tags.map(&:id)).to include(tag.id)
      expect(created.image).to eq(image)
    end

    it "valid params, image file" do
      attributes = {
        title_sv: 'Svensk', content_sv: 'Ett svenskt inlägg',
        title_en: 'English', content_en: 'An English post',
        image_file: Rack::Test::UploadedFile.new(File.open('spec/support/cover.jpg'))
      }

      expect do
        post :create, post: attributes
      end.to change(Post, :count).by(1)
      created = Post.last
      expect(response).to redirect_to(edit_post_path(created))
      expect(response).to have_http_status(302)
      expect(created.image.image.name).to eq('cover.jpg')
    end

    it "invalid params" do
      attributes = { title_sv: nil }

      expect do
        post :create, post: attributes
      end.to change(Post, :count).by(0)
      expect(response).to render_template(:new)
      expect(response).to have_http_status(422)
    end
  end

  describe "POST#update" do
    it "valid params" do
      tag = create(:tag)
      resource = create(:post, image: nil, title_sv: "Gammal")

      attributes = {
        title_sv: "Ny",
        image_file: Rack::Test::UploadedFile.new(File.open('spec/support/cover.jpg')),
        tag_ids: [tag.id]
      }

      patch :update, id: resource.id, post: attributes
      resource.reload
      expect(response).to redirect_to(edit_post_path(resource))
      expect(response).to have_http_status(302)
      expect(resource.title_sv).to eq("Ny")
      expect(resource.image.image.name).to eq('cover.jpg')
      expect(resource.tags.map(&:id)).to include(tag.id)
    end

    it "invalid params" do
      resource = create(:post, title_sv: "Gammal")
      attributes = { title_sv: nil }

      patch :update, id: resource.id, post: attributes
      resource.reload
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(422)
      expect(resource.title_sv).to eq("Gammal")
    end
  end
end
