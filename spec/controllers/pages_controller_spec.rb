require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  allow_user_to :manage, Page

  describe 'GET #index' do
    it 'renders page' do
      nav_item = create(:nav_item, :menu, title_sv: 'Första nav')
      create(:page, nav_item: nav_item)
      create(:page, nav_item: nav_item)

      get(:index)
      expect(response).to be_success
      expect(assigns(:nav_items).map(&:title_sv)).to eq(['Första nav'])
    end

    it 'sets orphaned pages' do
      nav_item = create(:nav_item, :menu)
      create(:page, title_sv: 'Inte orphan', nav_item: nav_item)
      create(:page, title_sv: 'Första')
      create(:page, title_sv: 'Andra')

      get(:index)
      expect(response).to be_success
      expect(assigns(:orphan_pages).map(&:title_sv)).to eq(['Första', 'Andra'])
    end
  end
  describe "GET show" do
    it "render show " do
        page = create(:page)
        get :show, id: page.to_param
        expect(response).to render_template :show
    end
  end
end
