class Admin::AdminBaseController < ApplicationController
  before_action :admin_required

  private
  def admin_required
    if current_user.nil?
      redirect_to root_path
    else
      redirect_to root_path unless current_user.admin
    end
  end
end
