require 'spec_helper'

describe "Users::Registration" do
  describe "routing" do
    it "get '/users/sign_up' -> users/registrations#new" do
      expect(get('/users/sign_up')).to route_to('users/registrations#new')
    end
  end
end
