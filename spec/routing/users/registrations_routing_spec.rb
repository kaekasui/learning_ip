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

    it "get '/users/email' -> users/registrations#email" do
      expect(get '/users/email').to route_to('users/registrations#email')
    end

    it "post '/users/send_email' -> users/registrations#send_email" do
      expect(post '/users/send_email').to route_to('users/registrations#send_email')
    end

    it "get '/users/name' -> users/registrations#name" do
      expect(get '/users/name').to route_to('users/registrations#name')
    end

    it "post '/users/update_name' -> users/registrations#update_name" do
      expect(post '/users/update_name').to route_to('users/registrations#update_name')
    end
  end
end
