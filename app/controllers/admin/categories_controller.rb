class Admin::CategoriesController < ApplicationController
  respond_to :js
  before_action :set_admin_category, only: [:show, :edit, :update, :destroy]

  def index
    @admin_categories = Category.all.order_updated_at
    @admin_category = Category.new
  end

  def show
  end

  def edit
  end

  def create
    @admin_category = Category.new(admin_category_params)
    @admin_category.save
    respond_with @admin_category, location: admin_categories_path
  end

  def update
    respond_to do |format|
      if @admin_category.update(admin_category_params)
        format.html { redirect_to admin_categories_path, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admin_category.destroy
    respond_to do |format|
      format.html { redirect_to admin_categories_url }
      format.json { head :no_content }
    end
  end

  private
    def set_admin_category
      @admin_category = Category.find(params[:id])
    end

    def admin_category_params
      params.require(:category).permit(:name)
    end
end
