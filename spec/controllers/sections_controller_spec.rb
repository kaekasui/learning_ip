require 'spec_helper'

describe SectionsController do
  describe '#show' do
    let(:section) { create(:section) }

    # :show テンプレートを表示すること
    it 'renders the :show template.' do
      get :show, id: section
      expect(response).to render_template(:show)
    end

    # 要求された試験種別を@sectionに割り当てること
    it 'assigns the requested section to @section' do
      get :show, id: section
      expect(assigns(:section)).to eq section
    end
  end
end
