require 'spec_helper'

describe CategoriesController do
  describe '#index' do
    let(:section) { create(:section) }
    let(:category) { create(:category) }

    # :show テンプレートを表示すること
    it 'renders the :show template.' do
      get :show, section_id: section, id: category
      expect(response).to render_template(:show)
    end

    # 要求された試験種別を@sectionに割り当てること
    it 'assigns the requested section to @section' do
      get :show, section_id: section, id: category
      expect(assigns(:section)).to eq section
    end

    # 要求されたカテゴリを@categoryに割り当てること
    it 'assigns the requested category to @category' do
      get :show, section_id: section, id: category
      expect(assigns(:category)).to eq category
    end
  end
end
