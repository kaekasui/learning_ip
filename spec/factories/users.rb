FactoryGirl.define do
  factory :user, class: User do
    email "user@example.com"
    password "password"
    admin false
  end
end
