class PostsController < ApplicationController

  def index
    @post_types = PostType.display_type
    @type = type_param.to_i
  end

  private
    def type_param
      params.require(:type)
    end
end
