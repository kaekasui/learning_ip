class Admin::DashboardController < Admin::AdminBaseController

  def index
    @users = User.all
  end
end
