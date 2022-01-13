require 'rails_helper'

RSpec.describe MapController, type: :controller do

  describe "GET #url" do
    before do
      map_controller = subject
      map_controller.params[:overview] = 'false'
      map_controller.params[:alternativs] = 'true'
      map_controller.params[:steps] = 'true'
      map_controller.params[:profile] = 'walking'
      # main building to campus III
      map_controller.params[:coordinates] = 
        '13p132964372634888%2C52p39388888702635;13p12498211860657%2C52p39511316914987' 
    end

    it 'returns the right url given the params' do
      expect(map_controller.url).to eq URI "https://api.mapbox.com/directions/v5/mapbox/walking/13%2E132964372634888%2C52%2E39388888702635;13%2E12498211860657%2C52%2E39511316914987?access_token=#{ENV['MAPBOX_ACCESS_TOKEN']}&steps=true"
    end

    it 'doesn\' permit additional attributes return the right url given the params' do
      map_controller.params[:forbidden] = 'value'
      expect(map_controller.url).to eq URI "https://api.mapbox.com/directions/v5/mapbox/walking/13%2E132964372634888%2C52%2E39388888702635;13%2E12498211860657%2C52%2E39511316914987?access_token=#{ENV['MAPBOX_ACCESS_TOKEN']}&steps=true"
    end
  end

  describe "GET #in_babelsberg" do
    it 'returns return true for points inside of babelsberg' do
      expect(map_controller.in_babelsberg('13.2,52.4')).to be_truthy
    end

    it 'returns return false for points outside of babelsberg' do
      expect(map_controller.in_babelsberg('13.0,52.4')).to be_falsey
    end
  end
end
