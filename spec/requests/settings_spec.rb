# frozen_string_literal: true

require 'rails_helper'
RSpec.describe('Settings', type: :request) do
  let(:admin) { create(:user, :admin) }

  it('visit settings and updates') do
    create(:image)
    sign_in(admin)
    get(settings_path)
    expect(response).to have_http_status(200)
    attributes = {
      settings: {
        cover_image_ids: %w[1 3 3 7],
        front_page_video: 'https://youtube.com'
      }
    }
    post(settings_path, params: attributes)

    expect(response).to redirect_to(settings_path)
    follow_redirect!
    expect(response).to have_http_status(200)
    expect(Settings.front_page_video).to eq('https://youtube.com')
    expect(Settings.cover_image_ids).to eq([1, 3, 7])
  end
end
