require 'rails_helper'

RSpec.describe Good, type: :model do
  fixtures :goods
  fixtures :sales
  context 'relations' do
    it 'sales' do
      expect((goods(:valid_params).sales << sales(:valid_params)).size).to eq 1
      should have_many(:sales).order(:date_of_sale).dependent(:destroy)
    end
  end
  context 'nested_attributes' do
    it 'sales' do
      should accept_nested_attributes_for(:sales).allow_destroy(true)
    end
  end
  context 'validations' do
    it 'presence' do
      expect(goods(:title_blank).valid?).to eq false
      should validate_presence_of(:title)
    end
    it 'uniqueness' do
      expect(Good.create(title: goods(:valid_params).title).valid?).to eq false
      should validate_uniqueness_of(:title)
    end
  end
  context 'class methods' do
    it 'seed' do
      Good.destroy_all if Good.first
      expect(Good.seed).to eq true
    end
  end
end
