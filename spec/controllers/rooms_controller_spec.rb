require 'rails_helper'
require 'rspec/rails'
require 'devise'

RSpec.describe RoomsController, type: :controller do
    it 'should get index' do
        get :index
        assert_response :success
    end

    context 'POST #create' do
        let!(:room) { create :room }
        let!(:floor) { create :floor }

        it 'should create a room' do
            params = { full_name: 'A Mocked room', floor_id: floor.id}
            expect { post(:create, params: { room: params })}.to change(Room, :count).by(1)
        end
    end

    context 'GET #show' do
        let!(:room) { create :room }

        it 'should show the room' do
            get :show, params: { id: room.id }
            assert_response :success
        end
    end

    context 'PUT #update' do
        let!(:room) {create :room}

        it 'should update a room' do
            params = { full_name: 'Changed room'}

            put(:update, params: { id: room.id, room: params })
            room.reload

            params.keys do |key|
                expect(room.attributes[key.to_s].to eq params[key])
            end
        end
    end

    context 'DELETE #destroy' do
        let!(:room) { create :room }
    
        it 'should delete room' do
            expect{delete(:destroy, params: { id: room.id })}.to change(Room, :count).by(-1)
        end
    end
end