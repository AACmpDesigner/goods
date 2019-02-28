require 'rails_helper'

RSpec.describe User, type: :model do
  valid_params = YAML.load_file(
    "#{fixture_path}/users.yml"
  ).with_indifferent_access[:valid_params]
  context 'validations' do
    it 'presence' do
      expect(User.create(valid_params.except(:email)).valid?).to eq false
      should validate_presence_of(:email)
    end
    it 'uniqueness' do
      User.create(valid_params)
      expect(User.create(valid_params).valid?).to eq false
    end
  end
  context 'token auth' do
    it 'generate' do
      user = User.create(valid_params)
      client_id = SecureRandom.urlsafe_base64(nil, false)
      token     = SecureRandom.urlsafe_base64(nil, false)
      user.tokens[client_id] = {
        token: BCrypt::Password.create(token),
        expiry: (Time.zone.now + 1.day).to_i
      }
      expect(user.valid_token?(token, client_id)).to eq true
    end
  end
  context 'class methods' do
    it 'seed' do
      User.destroy_all if User.first
      expect(User.seed).to eq true
    end
  end
end
