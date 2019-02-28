require 'rails_helper'

RSpec.describe 'Sales', type: :request do
  let(:valid_date_request) do
    {
      from: '2017-03-01',
      to: '2017-03-01'
    }
  end
  describe 'GET /sales' do
    it 'returns a success response' do
      get sales_path, params: valid_date_request
      expect(response).to have_http_status(:ok)
    end
  end
end
