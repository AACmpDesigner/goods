require 'rails_helper'

RSpec.describe 'Revenue', type: :request do
  describe 'GET /' do
    it 'returns a success response' do
      get root_path
      expect(response).to have_http_status(:ok)
      should render_template('revenue')
    end
  end
end
