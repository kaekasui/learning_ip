class SectionsController < ApplicationController
  before_action :section_params, only: [:show]

  def show
    default_setting = { display_cases_count: 5, test_time: 30, all_or_count: 1, non_or_time: 0 }
    @setting = if current_user
      Setting.where(user_id: current_user.id).first || Setting.new(default_setting)
    else
      Setting.new(default_setting)
    end
  end

  private
    def section_params
      @section = Section.find(params[:id])
    end
end
