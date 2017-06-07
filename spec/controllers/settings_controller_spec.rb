require 'rails_helper'

RSpec.describe(SettingsController) do
  render_views
  allow_user_to(:manage, :settings)

  describe('GET # edit') do
    it('renders properly') do
      get(:edit)
      expect(response).to have_http_status(200)
    end
  end

  describe('PATCH # update') do
    it('renders properly') do
      Settings.cover_image_ids = [1, 4, 5]
      params = { settings: { cover_image_ids: ['1', '2', '3', ''] } }
      patch(:update, params: params)
      expect(response).to redirect_to(settings_path)
      expect(Settings.cover_image_ids).to eq([1, 2, 3])
    end
  end
end
