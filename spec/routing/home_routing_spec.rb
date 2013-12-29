require 'spec_helper'

describe "Home" do
  describe "routing" do
    it "get '/' -> home#index" do
      expect(get('/')).to route_to('home#index')
    end
  end
end
