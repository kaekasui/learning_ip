class SectionsController < ApplicationController
  before_action :section_params, only: [:show]

  def show
  end

  private
    def section_params
      @section = Section.find(params[:id])
    end
end
