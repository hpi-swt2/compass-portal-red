require 'rails_helper'
require 'rspec/rails'
require 'devise'

RSpec.describe BuildingsController, type: :controller do
    it 'should get index' do
        get :index
        assert_response :success
    end

    context 'POST #create' do
        let!(:building) { create :building }

        it 'should create a building' do
            params = { name: 'A Mocked Building', floors: [] }
            expect { post(:create, params: { building: params })}.to change(Building, :count).by(1)
        end
    end

    context 'GET #show' do
        let!(:building) { create :building }

        it 'should show the building' do
            get :show, params: { id: building.id }
            assert_response :success
        end
    end

    context 'PUT #update' do
        let!(:building) {create :building}

        it 'should update a building' do
            params = { name: 'Changed Building', floors: []}

            put(:update, params: { id: building.id, building: params })
            building.reload

            params.keys do |key|
                expect(building.attributes[key.to_s].to eq params[key])
            end
        end
    end

    context 'DELETE #destroy' do
        let!(:building) { create :building }
    
        it 'should delete building' do
            expect{delete(:destroy, params: { id: building.id })}.to change(Building, :count).by(-1)
        end
    end
end