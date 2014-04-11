FactoryGirl.define do
  factory :virtual_user, class: VirtualUser do
    email "virtual_user@example.com"
    type "VirtualUser"
    admin false
  end
end
