class SettingsController < ApplicationController
  respond_to :js
  before_action :set_setting, :set_section, only: [:create, :update]

  def create
    @setting = Setting.new(setting_params)
    @setting.update_attributes(user_id: current_user.id)
    @setting.save
    respond_with @setting, location: section_path(@section.id) 
  end

  def update
    @setting.update_attributes(setting_params)
    @setting.update_attributes(user_id: current_user.id)
    respond_with @setting, location: section_path(@section.id) 
  end

  private
    def set_setting 
      @setting = Setting.where(user_id: current_user.id).first
    end

    def set_section
      section_id = params.require(:section_id)
      @section = Section.find(section_id)
    end

    def setting_params
      params.require(:setting).permit(:display_cases_count, :test_time, :all_or_count, :non_or_time, :random_check)
    end
end
