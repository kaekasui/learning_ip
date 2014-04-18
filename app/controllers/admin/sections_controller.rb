class Admin::SectionsController < ApplicationController
  before_action :set_admin_section, only: [:show, :edit, :update, :destroy]

  def index
    @admin_sections = Section.all
  end

  def show
  end

  def new
    @admin_section = Section.new
  end

  def edit
  end

  def create
    @admin_section = Section.new(admin_section_params)

    respond_to do |format|
      if @admin_section.save
        format.html { redirect_to ['admin', @admin_section], notice: 'Section was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_section }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_section.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @admin_section.update(admin_section_params)
        format.html { redirect_to ['admin', @admin_section], notice: 'Section was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_section.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admin_section.destroy
    respond_to do |format|
      format.html { redirect_to admin_sections_url }
      format.json { head :no_content }
    end
  end

  private
    def set_admin_section
      @admin_section = Section.find(params[:id])
    end

    def admin_section_params
      params.require(:section).permit(:name)
    end
end
