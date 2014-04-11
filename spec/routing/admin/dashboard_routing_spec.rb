require 'spec_helper'

describe "Dashboard" do
  describe "routing" do
    it "get '/' -> admin/dashboard#index" do
      expect(get 'admin').to route_to('admin/dashboard#index')
    end
  end
end
