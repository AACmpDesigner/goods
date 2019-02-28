require 'rails_helper'

RSpec.describe 'Goods', type: :request do
  good_params =
    YAML.load_file("#{fixture_path}/goods.yml").with_indifferent_access
  sale_params =
    YAML.load_file("#{fixture_path}/sales.yml").with_indifferent_access
  user_params =
    YAML.load_file(
      "#{fixture_path}/users.yml"
    ).with_indifferent_access[:valid_params]
  json_headers = {
    CONTENT_TYPE: 'application/json',
    ACCEPT: 'application/json'
  }
  let(:valid_attributes) do
    valid_params = good_params[:valid_params].deep_dup
    valid_params[:title] = valid_params[:title] + Time.now.to_i.to_s
    valid_params
  end

  let(:sale_valid_attributes) do
    sale_params[:valid_params]
  end

  let(:auth_headers) do
    User.create(user_params)
    post api_user_session_path,
         params: user_params.slice(:email, :password).to_json,
         headers: json_headers
    client = response.headers['client']
    token = response.headers['access-token']
    expiry = response.headers['expiry']
    token_type = response.headers['token-type']
    uid = response.headers['uid']
    auth_params = {
      'access-token' => token,
      'client' => client,
      'uid' => uid,
      'expiry' => expiry,
      'token_type' => token_type
    }
    auth_params
  end

  describe 'GET /api/goods' do
    it 'returns a success response' do
      get api_goods_path, headers: json_headers
      expect(response).to have_http_status(:ok)
      should render_template('index')
    end
  end

  describe 'POST /api/goods' do
    it 'returns a success response' do
      post api_goods_path,
           params: valid_attributes.to_json,
           headers: json_headers.merge(auth_headers)
      expect(response).to have_http_status(:created)
      should render_template('show')
    end
  end

  describe 'GET /api/goods/new' do
    it 'returns a success response' do
      get new_api_good_path, headers: json_headers
      expect(response).to have_http_status(:ok)
      should render_template('new')
    end
  end

  describe 'GET /api/goods/:id/edit' do
    it 'returns a success response' do
      get edit_api_good_path(Good.create(valid_attributes)),
          headers: json_headers
      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'GET /api/goods/:id' do
    it 'returns a success response' do
      get api_good_path(Good.create(valid_attributes)), headers: json_headers
      expect(response).to have_http_status(:ok)
      should render_template('show')
    end
  end

  describe 'PUT /api/goods/:id' do
    it 'returns a success response' do
      good = Good.create(valid_attributes)
      put api_good_path(good),
          params: valid_attributes.to_json,
          headers: json_headers.merge(auth_headers)
      expect(response).to have_http_status(:ok)
      should render_template('show')
    end
  end

  describe 'DELETE /api/goods/:id' do
    it 'returns a success response' do
      good = Good.create(valid_attributes)
      delete api_good_path(good), headers: json_headers.merge(auth_headers)
      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'GET /api/goods/:id/sales' do
    it 'returns a success response' do
      get sales_api_good_path(Good.create(valid_attributes)),
          headers: json_headers
      expect(response).to have_http_status(:ok)
      should render_template('sales')
    end
  end

  describe 'GET /api/goods/:id/sales/:sale_id' do
    it 'returns a success response' do
      good = Good.create valid_attributes
      sale = good.sales.create sale_valid_attributes
      get sales_api_good_path(good),
          params: { sale_id: sale.id }.to_json,
          headers: json_headers
      expect(response).to have_http_status(:ok)
      should render_template('sales')
    end
  end
end
