class CategoriesController < ApplicationController
  before_action :section_params, :category_params, only: [:show]

  def show
  end

  private
    def section_params
      @section = Section.find(params[:section_id])
    end

    def category_params
      @category = Category.find(params[:id])
    end
end
