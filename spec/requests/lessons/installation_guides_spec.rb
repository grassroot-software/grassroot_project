require 'rails_helper'

RSpec.describe 'Installation Guides' do
  describe 'GET #index' do
    it 'renders the installation guides index' do
      get lessons_installation_guides_path

      expect(response).to have_http_status(:ok)
    end
  end
end
