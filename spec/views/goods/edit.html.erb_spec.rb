require 'rails_helper'

RSpec.describe 'goods/edit', type: :view do
  before(:each) do
    @good = assign(:good, Good.create!(title: 'Corn'))
  end

  it 'renders the edit good form' do
    render
    expect(rendered).to match(/Corn/)
    assert_select 'form[action=?][method=?]', good_path(@good), 'post' do
    end
  end
  it 'infers the controller action' do
    expect(controller.request.path_parameters[:action]).to eq('edit')
  end
end
