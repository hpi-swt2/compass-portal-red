require 'rails_helper'
require 'rspec/rails'
require 'devise'

RSpec.describe ChairsController, type: :controller do
  it 'gets index' do
    get :index
    assert_response :success
  end

  context 'POST #create' do
    let!(:chair) { create :chair }

    it 'creates a chair' do
      params = { name: 'A Mocked Chair', floors: [] }
      expect { post(:create, params: { chair: params }) }.to change(Chair, :count).by(1)
    end
  end

  context 'GET #show' do
    let!(:chair) { create :chair }

    it 'shows the chair' do
      get :show, params: { id: chair.id }
      assert_response :success
    end
  end

  context 'PUT #update' do
    let!(:chair) { create :chair }

    it 'updates a chair' do
      params = { name: 'Changed Chair', floors: [] }

      put(:update, params: { id: chair.id, chair: params })
      chair.reload

      params.keys do |key|
        expect(chair.attributes[key.to_s]).to eq(params[key])
      end
    end
  end

  context 'DELETE #destroy' do
    let!(:chair) { create :chair }

    it 'deletes chair' do
      expect { delete(:destroy, params: { id: chair.id }) }.to change(Chair, :count).by(-1)
    end
  end
end
