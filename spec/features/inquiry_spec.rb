require 'spec_helper'

feature 'inquiry' do

  # 問い合わせをする
  scenario 'makes inquiries.' do
    visit root_path
    inquiry_message = "問い合わせます。"
    fill_in 'inquiry_content', with: inquiry_message 
    click_button I18n.t("actions.create")
    
    expect(page).to have_content(I18n.t("messages.send_inquiry"))

    inquiry = Inquiry.last
    expect(inquiry.content).to eq inquiry_message
  end
end
