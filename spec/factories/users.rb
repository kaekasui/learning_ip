FactoryGirl.define do
  factory :original_user, class: User do
    email "original_user@example.com"
    password "password"
  end
end
