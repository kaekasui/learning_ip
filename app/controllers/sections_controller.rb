class SectionsController < ApplicationController
  before_action :section_params, only: [:show]

  def show
    @setting = if current_user
      Setting.where(user_id: current_user.id).first || Setting.new(radio_category: 1, test_case: 5, test_time: 30, radio_time: 0)
    else
      Setting.new(radio_category: 1, test_case: 5, test_time: 30, radio_time: 0)
    end
  end

  private
    def section_params
      @section = Section.find(params[:id])
    end
end
