class Admin::CasesController < ApplicationController
  before_action :set_admin_case, only: [:show, :edit, :update, :destroy]

  def index
    @admin_cases = Case.all
  end

  def show
  end

  def new
    @admin_case = Case.new
  end

  def edit
  end

  def create
    @admin_case = Case.new(admin_case_params)

    respond_to do |format|
      if @admin_case.save
        format.html { redirect_to ['admin', @admin_case], notice: 'Case was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_case }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_case.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @admin_case.update(admin_case_params)
        format.html { redirect_to ['admin', @admin_case], notice: 'Case was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_case.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admin_case.destroy
    respond_to do |format|
      format.html { redirect_to admin_cases_url }
      format.json { head :no_content }
    end
  end

  private
    def set_admin_case
      @admin_case = Case.find(params[:id])
    end

    def admin_case_params
      params.require(:case).permit(:section_id, :category_id, :age, :content, :answer_a, :answer_b, :answer_c, :answer_d, :answer, :comment)
    end
end
