require 'rails_helper'

RSpec.describe 'goods/new', type: :view do
  before(:each) do
    assign(:good, Good.new(title: 'Cassava'))
  end

  it 'renders new good form' do
    render
    expect(rendered).to match(/Cassava/)
    assert_select 'form[action=?][method=?]', goods_path, 'post' do
    end
  end
  it 'infers the controller action' do
    expect(controller.request.path_parameters[:action]).to eq('new')
  end
end
