require 'rails_helper'

RSpec.describe PositionsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Position. As you add validations to Position, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { title_sv: 'Näringslivsansvarig',
      title_en: 'Head of corporate relations',
      desc_en: 'Job',
      desc_sv: 'Jobb',
      committee_sv: 'Näringslivsutskottet', 
      committee_en: 'Corporate relations committee',
      number: 1,
      apply_url: 'http://tlth.se',
      term: '2015/2016'
    }
  }

  let(:invalid_attributes) {
    {title_en: ''}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PositionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      position = Position.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      position = Position.create! valid_attributes
      get :edit, params: {id: position.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Position" do
        expect {
          post :create, params: {position: valid_attributes}, session: valid_session
        }.to change(Position, :count).by(1)
      end

      it "redirects to the created position" do
        post :create, params: {position: valid_attributes}, session: valid_session
        expect(response).to redirect_to(positions_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {position: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          title_sv: 'Datoransvarig',
          title_en: 'Computer responsible'
        }
      }

      it "updates the requested position" do
        position = Position.create! valid_attributes
        put :update, params: {id: position.to_param, position: new_attributes}, session: valid_session
        position.reload
        expect(position.title_sv).to eq('Datoransvarig')
      end

      it "redirects to the positions path" do
        position = Position.create! valid_attributes
        put :update, params: {id: position.to_param, position: valid_attributes}, session: valid_session
        expect(response).to redirect_to(positions_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        position = Position.create! valid_attributes
        put :update, params: {id: position.to_param, position: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested position" do
      position = Position.create! valid_attributes
      expect {
        delete :destroy, params: {id: position.to_param}, session: valid_session
      }.to change(Position, :count).by(-1)
    end

    it "redirects to the positions list" do
      position = Position.create! valid_attributes
      delete :destroy, params: {id: position.to_param}, session: valid_session
      expect(response).to redirect_to(positions_path)
    end
  end

end
