module ApplicationHelper

  def namespace
    controller.controller_path.split('/')[-2]
  end
end
