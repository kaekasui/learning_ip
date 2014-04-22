class SectionsController < ApplicationController
  before_action :section_params, only: [:show]

  def show
    @setting = Setting.where(user_id: current_user.id).first || Setting.new(radio_category: 1, test_case: 5)
  end

  private
    def section_params
      @section = Section.find(params[:id])
    end
end
