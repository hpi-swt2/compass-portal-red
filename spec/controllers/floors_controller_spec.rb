require 'rails_helper'
require 'rspec/rails'
require 'devise'

RSpec.describe FloorsController, type: :controller do
    it 'should get index' do
        get :index
        assert_response :success
    end

    context 'POST #create' do
        let!(:floor) { create :floor }
        let!(:building) { create :building }

        it 'should create a floor' do
            params = { name: 'A Mocked floor', building_id: building.id}
            expect { post(:create, params: { floor: params })}.to change(Floor, :count).by(1)
        end
    end

    context 'GET #show' do
        let!(:floor) { create :floor }

        it 'should show the floor' do
            get :show, params: { id: floor.id }
            assert_response :success
        end
    end

    context 'PUT #update' do
        let!(:floor) {create :floor}

        it 'should update a floor' do
            params = { name: 'Changed floor'}

            put(:update, params: { id: floor.id, floor: params })
            floor.reload

            params.keys do |key|
                expect(floor.attributes[key.to_s].to eq params[key])
            end
        end
    end

    context 'DELETE #destroy' do
        let!(:floor) { create :floor }
    
        it 'should delete floor' do
            expect{delete(:destroy, params: { id: floor.id })}.to change(Floor, :count).by(-1)
        end
    end
end