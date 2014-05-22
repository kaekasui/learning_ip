require 'spec_helper'

describe 'home/index' do
  before do
    @sections = Section.limit(12)
    @post_types = PostType.display_type
    @inquiry = Inquiry.new
  end

  # お問い合わせであることを認識する文字列が表示されること
  it 'displays the inquiry title.' do
    render
    expect(rendered).to have_selector(".row", content: I18n.t("home.inquiry"))
  end
end
