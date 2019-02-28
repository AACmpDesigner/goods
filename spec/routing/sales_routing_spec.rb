require 'rails_helper'

RSpec.describe SalesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/sales').to route_to('sales#index')
      should route(:get, '/sales').to('sales#index')
    end
  end
end
