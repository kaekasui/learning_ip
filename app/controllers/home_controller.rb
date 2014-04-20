class HomeController < ApplicationController

  def index
    @post_types = PostType.display_type
    @inquiry = Inquiry.new
    @sections = Section.limit(12)
    @section_size = 12 / @sections.count
  end
end
