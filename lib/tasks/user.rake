# encoding: utf-8
# command: rake user:set_admin

namespace :user do
  desc "Add administrator authority to user."
  task set_admin: :environment do
    raise "ENV['USER_CODE'] is not found." unless ENV['USER_CODE']
    code = ENV['USER_CODE']
    user = User.where(code: code).first
    raise "user is not found." if user.blank?
    user.admin = true
    user.save!
  end
end
