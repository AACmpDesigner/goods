class Sale < ApplicationRecord
  # relations
  belongs_to :good
  # validations
  validate :check_date_format
  validates :price, presence: true, numericality: true
  # validation method
  def check_date_format
    Date.strptime(date_of_sale.to_s, '%Y-%m-%d')
  rescue ArgumentError
    scope = 'activerecord.errors.models.sale.attributes'
    errors.add(:date_of_sale, I18n.t('date.invalid', scope: scope))
  end
end
