require 'spec_helper'

feature 'display on the top page.' do

  # 試験区分を表示する
  scenario 'display the section.' do
    section1 = create(:section, name: "section1")
    section2 = create(:section, name: "section2")
    visit root_path

    expect(page).to have_content("section1")
    expect(page).to have_content("section2")
  end

  # 告知情報を表示する
  scenario 'display the posts.' do
    post_type = create(:post_type, display: true)
    post = create(:post, post_type_id: post_type.id)
    visit root_path

    expect(page).to have_content(post_type.name)
    expect(page).to have_content(post.title)

    post_type2 = create(:post_type, name: "display", display: false)
    post2 = create(:post, post_type_id: post_type2.id, title: "display")
    visit root_path

    expect(page).not_to have_content(post_type2.name)
    expect(page).not_to have_content(post2.title)
  end
end
