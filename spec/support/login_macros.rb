module LoginMacros
  def login(user)
    visit root_path
    click_link I18n.t("account.login")
    fill_in User.human_attribute_name(:email), with: user.email
    fill_in User.human_attribute_name(:password), with: user.password
    click_button I18n.t("actions.login")
  end 
end
