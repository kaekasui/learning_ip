class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def index
    @post_types = PostType.display_type
    @type = type_param.to_i
  end

  def show
  end

  private
    def type_param
      params.require(:type)
    end

    def set_post
      @post = Post.find(params[:id])
    end
end
