FactoryGirl.define do
  factory :twitter_user, class: TwitterUser do
    email ""
    name "abcdefg"
    screen_name "名前A"
    uid "88888888"
    type "TwitterUser"
    admin false
    provider "twitter"
  end
end
