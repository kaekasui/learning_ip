require "spec_helper"

describe NoticeMailer do
  describe "update_email" do
    let(:user) { create(:virtual_user, email: "a@example.com") }
    let(:mail) { NoticeMailer.change_email(user) }

    it "renders the headers." do
      expect(mail.subject).to eq I18n.t("messages.change_email")
    end

    it "mail to the email." do
      expect(mail.to).to have_content(user.email)
    end

    it "mail from the 'aprende' administrator." do
      expect(mail.from).to have_content(ENV["MAIL_ADDRESS"])
    end
  end

end
