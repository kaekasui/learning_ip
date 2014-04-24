class InquiriesController < ApplicationController

  def create
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.update_attributes(user_id: current_user.id) if current_user

    respond_to do |format|
      if @inquiry.save
        format.html { redirect_to root_path, notice: I18n.t("messages.send_inquiry") }
      end
    end
  end

  private
    def inquiry_params
      params.require(:inquiry).permit(:content, :user_id)
    end
end
