class Admin::PostTypesController < ApplicationController
  respond_to :js
  before_action :set_admin_post_type, only: [:show, :edit, :update, :destroy]

  def index
    @admin_post_types = PostType.all
    @admin_post_type = PostType.new
  end

  def show
  end

  def edit
  end

  def create
    @admin_post_type = PostType.new(admin_post_type_params)
    @admin_post_type.save
    respond_with @admin_post_type, location: admin_post_types_path
  end

  def update
    respond_to do |format|
      if @admin_post_type.update(admin_post_type_params)
        format.html { redirect_to @admin_post_type, notice: 'Post type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_post_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admin_post_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_post_types_url }
      format.json { head :no_content }
    end
  end

  private
    def set_admin_post_type
      @admin_post_type = PostType.find(params[:id])
    end

    def admin_post_type_params
      params.require(:post_type).permit(:name, :deleted_at)
    end
end
