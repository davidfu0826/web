require 'rails_helper'

RSpec.describe(StaticPagesController, type: :controller) do
  describe('GET # robots') do
    it('renders robots as txt') do
      get(:robots, format: :txt)
      expect(response).to render_template('robots')
    end
  end
end
