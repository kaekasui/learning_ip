require 'spec_helper'
require 'rake'

describe "set_admin" do
  before :all do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require "lib/tasks/user", [Rails.root.to_s]
    Rake::Task.define_task(:environment)
  end

  describe "user:set_admin" do
    let(:user) { create(:user) }

    context "when execute the rake tasks." do
      context "without the option." do
        it "display the error messages." do
          Rake::Task["user:set_admin"].reenable
          expect {@rake.invoke_task "user:set_admin"}.to raise_error
        end
      end

      context "with options." do
        context "when there is no user." do
          it "display the error messages." do
            ENV['USER_CODE'] = "sample"
            Rake::Task["user:set_admin"].reenable
            expect {@rake.invoke_task "user:set_admin"}.to raise_error
          end
        end

        context "when there is user." do
          before do
            ENV['USER_CODE'] = user.code
            Rake::Task["user:set_admin"].reenable
          end

          it "don't display error messages." do
            expect {@rake.invoke_task "user:set_admin"}.not_to raise_error
          end

          it "become to the administrator." do
            @rake.invoke_task "user:set_admin"
	    p User.where(code: user.code)
            expect(User.where(code: user.code).first.admin).to be_true
          end
        end
      end
    end
  end
end
