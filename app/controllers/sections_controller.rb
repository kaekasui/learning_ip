class SectionsController < ApplicationController
  before_action :section_params, only: [:show]

  def show
    @sections = Section.limit(12)
  end

  private
    def section_params
      @section = Section.find(params[:id])
    end
end
