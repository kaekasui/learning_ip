require 'spec_helper'

describe "Users::OmniauthCallbacks" do
  describe "routing" do
    it "get 'users/disconnect/twitter' -> users/omniauth_callbacks#disconnect" do
      expect(delete '/users/disconnect/twitter').to route_to('users/omniauth_callbacks#disconnect', provider: "twitter")
    end
  end
end
