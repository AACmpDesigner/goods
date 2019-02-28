class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.belongs_to :good, index: true
      t.date :date_of_sale, index: true
      t.float :price
      t.timestamps
    end
  end
end
