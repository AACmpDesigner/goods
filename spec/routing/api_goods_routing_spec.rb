require 'rails_helper'

RSpec.describe Api::GoodsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/goods').to route_to('api/goods#index')
      should route(:get, '/api/goods').to('api/goods#index')
    end

    it 'routes to #new' do
      expect(get: '/api/goods/new').to route_to('api/goods#new')
      should route(:get, '/api/goods/new').to('api/goods#new')
    end

    it 'routes to #show' do
      expect(get: '/api/goods/1').to route_to('api/goods#show', id: '1')
      should route(:get, '/api/goods/1').to('api/goods#show', id: 1)
    end

    it 'routes to #edit' do
      expect(get: '/api/goods/1/edit').to route_to('api/goods#edit', id: '1')
      should route(:get, '/api/goods/1/edit').to('api/goods#edit', id: 1)
    end

    it 'routes to #create' do
      expect(post: '/api/goods').to route_to('api/goods#create')
      should route(:post, '/api/goods').to('api/goods#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/goods/1').to route_to('api/goods#update', id: '1')
      should route(:put, '/api/goods/1').to('api/goods#update', id: 1)
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/goods/1').to route_to('api/goods#update', id: '1')
      should route(:patch, '/api/goods/1').to('api/goods#update', id: 1)
    end

    it 'routes to #destroy' do
      expect(delete: '/api/goods/1').to route_to('api/goods#destroy', id: '1')
      should route(:delete, '/api/goods/1').to('api/goods#destroy', id: 1)
    end

    it 'routes to #sales' do
      expect(get: '/api/goods/1/sales').to route_to('api/goods#sales', id: '1')
      should route(:get, '/api/goods/1/sales').to('api/goods#sales', id: 1)
    end

    it 'routes to #sale' do
      expect(
        get: '/api/goods/1/sales/1'
      ).to route_to('api/goods#sale', id: '1', sale_id: '1')
      should route(:get, '/api/goods/1/sales/1').to(
        'api/goods#sale', id: 1, sale_id: 1
      )
    end
  end
end
