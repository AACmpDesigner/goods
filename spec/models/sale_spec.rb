require 'rails_helper'

RSpec.describe Sale, type: :model do
  fixtures :goods
  fixtures :sales
  context 'relations' do
    it 'good' do
      expect(
        (sales(:valid_params).good = goods(:valid_params)).id
      ).to eq sales(:valid_params).good.id
      should belong_to(:good)
    end
  end
  context 'validations' do
    it 'date format' do
      expect(sales(:invalid_date_format).valid?).to eq false
    end
    it 'presence' do
      expect(sales(:blank_price).valid?).to eq false
      should validate_presence_of(:price)
    end
    it 'numericality' do
      expect(sales(:invalid_price).valid?).to eq false
      should validate_numericality_of(:price)
    end
  end
end
