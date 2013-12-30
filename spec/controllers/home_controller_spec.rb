require 'spec_helper'

describe HomeController do
  describe '#index' do
    it 'response code is 200.' do
      get :index
      expect(response.status).to eq 200
    end

    it 'render template :index' do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
