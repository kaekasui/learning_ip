require 'spec_helper'

describe "Users::Registration" do
  describe "routing" do
    it "get '/users/sign_up' -> users/registrations#new" do
      expect(get('/users/sign_up')).to route_to('users/registrations#new')
    end

    it "get '/users/profile' -> users/registrations#show" do
      expect(get '/users/profile').to route_to('users/registrations#show')
    end

    it "get '/users/edit' -> users/registrations#edit" do
      expect(get '/users/edit').to route_to('users/registrations#edit')
    end
  end
end
