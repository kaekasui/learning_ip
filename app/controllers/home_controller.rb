class HomeController < ApplicationController

  def index
    @post_types = PostType.display_type
    @inquiry = Inquiry.new
  end
end
