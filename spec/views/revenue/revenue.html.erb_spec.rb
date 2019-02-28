require 'rails_helper'

RSpec.describe 'revenue/revenue', type: :view do
  it 'renders a list of revenues' do
    render
    expect(rendered).to match(/{{good.title}}/)
    expect(rendered).to match(/{{good.revenue}}/)
    expect(rendered).to match(/{{table_data.total_revenue}}/)
  end
  it 'infers the controller action' do
    expect(controller.request.path_parameters[:action]).to eq('revenue')
  end
end
