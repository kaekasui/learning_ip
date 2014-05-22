FactoryGirl.define do
  factory :post, class: Post do
    post_at "2014-08-01 09:00:00"
    title "MyString"
    content "MyText"
  end
end
