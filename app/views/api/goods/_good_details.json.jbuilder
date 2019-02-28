if good.new_record?
  json.extract! good, :title
else
  json.extract! good, :id, :title
end
json.sales good.sales, partial: 'api/goods/sale', as: :sale
