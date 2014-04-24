FactoryGirl.define do
  factory :case, class: Case do
    age "Age"
    content "MyText"
    answer_a "MyText"
    answer_b "MyText"
    answer_c "MyText"
    answer_d "MyText"
    answer "MyString"
    comment "MyText"
  end
end
