require 'rails_helper'

RSpec.describe 'Goods', type: :request do
  good_params =
    YAML.load_file("#{fixture_path}/goods.yml").with_indifferent_access

  let(:valid_attributes) do
    valid_params = good_params[:valid_params].deep_dup
    valid_params[:title] = valid_params[:title] + Time.now.to_i.to_s
    valid_params
  end

  describe 'GET /goods' do
    it 'returns a success response' do
      get goods_path
      expect(response).to have_http_status(:ok)
      should render_template('index')
    end
  end

  describe 'POST /goods' do
    it 'returns a success response' do
      post goods_path, params: { good: valid_attributes }
      expect(response).to redirect_to(Good.last)
      should redirect_to(good_path(Good.last))
    end
  end

  describe 'GET /goods/new' do
    it 'returns a success response' do
      get new_good_path
      expect(response).to have_http_status(:ok)
      should render_template('new')
    end
  end

  describe 'GET /goods/:id/edit' do
    it 'returns a success response' do
      get edit_good_path(Good.create(valid_attributes))
      expect(response).to have_http_status(:ok)
      should render_template('edit')
    end
  end

  describe 'GET /goods/:id' do
    it 'returns a success response' do
      get good_path(Good.create(valid_attributes))
      expect(response).to have_http_status(:ok)
      should render_template('show')
    end
  end

  describe 'PUT /goods/:id' do
    it 'returns a success response' do
      good = Good.create(valid_attributes)
      put good_path(good), params: { good: valid_attributes }
      expect(response).to redirect_to(good)
      should redirect_to(good_path(good))
    end
  end

  describe 'DELETE /goods/:id' do
    it 'returns a success response' do
      good = Good.create(valid_attributes)
      delete good_path(good)
      expect(response).to redirect_to(goods_url)
      should redirect_to(goods_url)
    end
  end
end
