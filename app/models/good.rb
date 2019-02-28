require 'roo'
class Good < ApplicationRecord
  # relations
  has_many :sales, -> { order(:date_of_sale) },
           dependent: :destroy,
           inverse_of: :good
  # nested_attributes
  accepts_nested_attributes_for :sales,
                                allow_destroy: true, reject_if: :all_blank
  # validations
  validates :title, presence: true, uniqueness: true
  # class methods
  def self.seed
    return true if Good.first

    xlsx = Roo::Excelx.new(
      Rails.root.join('app', 'files', 'xlsx', 'Test task goods.xlsx')
    )
    header = nil
    xlsx.each_row_streaming do |row|
      if header.blank?
        header = row.map(&:value)
      else
        good = nil
        sales = []
        row.each_with_index do |cell, index|
          if good.blank?
            good = cell.value
            return true if good.blank?
          else
            sales.push(date_of_sale: header[index], price: cell.value)
          end
        end
        Good.create!(title: good).sales.create!(sales) if sales.present?
      end
    end
  end
end
