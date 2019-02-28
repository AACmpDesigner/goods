require 'rails_helper'

RSpec.describe 'goods/show', type: :view do
  before(:each) do
    @good = assign(:good, Good.create!(title: 'Bamboo'))
  end

  it 'renders attributes' do
    controller.extra_params = { id: @good.id }
    render
    expect(rendered).to match(/Bamboo/)
    expect(controller.request.fullpath).to eq good_path(@good)
  end
  it 'infers the controller action' do
    expect(controller.request.path_parameters[:action]).to eq('show')
  end
end
