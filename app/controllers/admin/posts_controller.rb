class Admin::PostsController < ApplicationController
  before_action :set_admin_post, only: [:show, :edit, :update, :destroy]

  def index
    @admin_posts = Post.all
  end

  def show
  end

  def new
    @admin_post = Post.new
  end

  def edit
  end

  def create
    @admin_post = Post.new(admin_post_params)

    respond_to do |format|
      if @admin_post.save
        format.html { redirect_to ['admin', @admin_post], notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_post }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @admin_post.update(admin_post_params)
        format.html { redirect_to ['admin', @admin_post], notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admin_post.destroy
    respond_to do |format|
      format.html { redirect_to admin_posts_url }
      format.json { head :no_content }
    end
  end

  private
    def set_admin_post
      @admin_post = Post.find(params[:id])
    end

    def admin_post_params
      params.require(:post).permit(:post_at, :timestamp, :title, :content, :deleted_at)
    end
end
