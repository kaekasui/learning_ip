require 'spec_helper'

# 管理者がカテゴリを管理する
feature 'administrators manage categories.' do
  background do
    user = create(:original_user, admin: true)
    login user
  end 

  # カテゴリを登録し、そのカテゴリが表示されること
  # カテゴリを登録し、そのカテゴリがデータとして登録されること
  scenario 'creates a category, and display the category', js: true do
    visit admin_categories_path

    wait_for_ajax
    category_name = "カテゴリ名"
    fill_in 'category_name', with: category_name + "\n"
    expect(page).to have_content(category_name)
    expect(Category.last.name).to eq category_name
  end

  # カテゴリを編集する
  scenario 'updates a category.' do
    visit admin_categories_path

    category = create(:category)
    category_name = "カテゴリ名"
    visit edit_admin_category_path(id: category.id)
    fill_in 'category_name', with: category_name
    click_button I18n.t("actions.update")
    expect(category.reload.name).to eq category_name
  end

  # カテゴリを削除する
  scenario 'deletes a category.' do
    visit admin_categories_path

    category = create(:category)
    pending "削除対象を探す"
  end
end
