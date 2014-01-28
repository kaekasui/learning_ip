require 'spec_helper'

describe "Users::Session" do
  describe "routing" do
    it "get '/users/sign_in' -> users/sessions#new" do
      expect(get('/users/sign_in')).to route_to('users/sessions#new')
    end
  end
end
