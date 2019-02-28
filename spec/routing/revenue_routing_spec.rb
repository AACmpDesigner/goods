require 'rails_helper'

RSpec.describe RevenueController, type: :routing do
  describe 'routing' do
    it 'routes to #revenue' do
      expect(get: '/').to route_to('revenue#revenue')
      should route(:get, '/').to('revenue#revenue')
    end
  end
end
