require 'rails_helper'

RSpec.describe 'goods/index', type: :view do
  before(:each) do
    assign(:goods, [Good.create!(title: 'Beef'), Good.create!(title: 'Coal')])
  end

  it 'renders a list of goods' do
    render
    expect(rendered).to match(/Beef/)
    expect(rendered).to match(/Coal/)
  end
  it 'infers the controller action' do
    expect(controller.request.path_parameters[:action]).to eq('index')
  end
end
