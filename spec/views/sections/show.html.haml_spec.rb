require 'spec_helper'

describe 'sections/show' do
  before do
    @setting = Setting.new
    @section = create(:section)
    view.stub(:current_user) { false }
  end

  # パンくずリストに試験種別の名称が表示されること
  it 'displays the section title on the breadcrumb.' do
    render
    expect(rendered).to have_selector(".breadcrumb", content: @section.name)
  end
end
