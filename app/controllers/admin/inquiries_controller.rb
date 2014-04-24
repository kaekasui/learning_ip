class Admin::InquiriesController < ApplicationController
  before_action :set_admin_inquiry, only: [:destroy]

  def index
    @admin_inquiries = Inquiry.all
  end

  def destroy
    @admin_inquiry.destroy
    respond_to do |format|
      format.html { redirect_to admin_inquiries_url }
      format.json { head :no_content }
    end
  end

  private
    def set_admin_inquiry
      @admin_inquiry = Inquiry.find(params[:id])
    end

    def admin_inquiry_params
      params.require(:inquiry).permit(:content, :user_id)
    end
end
