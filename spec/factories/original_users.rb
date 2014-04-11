FactoryGirl.define do
  factory :original_user, class: OriginalUser do
    email "original_user@example.com"
    password "password"
    type "OriginalUser"
    admin false
  end
end
