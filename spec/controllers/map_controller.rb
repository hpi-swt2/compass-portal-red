require 'rails_helper'

RSpec.describe MapController, type: :controller do
#http://localhost:3000/directions/walking/
#13p132964372634888%2C52p39388888702635;13p12498211860657%2C52p39511316914987
#?overview=false&alternatives=true&steps=true
  describe "GET #directions" do
    before do
      request.params[:overview] = 'false'
      request.params[:alternativs] = 'true'
      request.params[:steps] = 'true'
      request.params[:profile] = 'walking'
    end

    # test route in one test to prevent excessive API calls
    it 'should return a route' do
      request.params[:coordinates] = '13p132964372634888%2C52p39388888702635;13p12498211860657%2C52p39511316914987' # main building to campus III
      # get :directions, params: {a: 'b'}
      get :directions, params: request.params, format: :json
      
      expect(response.body).to eq(200)
      parsed_body = JSON.parse(response.body)
    end

    it 'should block requests from or to outside HPI' do
      request.params[:coordinates] = '13p0%2C52p4;13p2%2C52p4'
      get :directions
      expect(response).to have_http_status(201)
    end 
  end

  describe "GET #url" do

    it 'should return the right url given the params' do
      subject.params[:overview] = 'false'
      subject.params[:alternativs] = 'true'
      subject.params[:steps] = 'true'
      subject.params[:profile] = 'walking'
      subject.params[:coordinates] = '13p132964372634888%2C52p39388888702635;13p12498211860657%2C52p39511316914987' # main building to campus III
      expect(subject.url).to eq(URI 'https://api.mapbox.com/directions/v5/mapbox/walking/13%2E132964372634888%2C52%2E39388888702635;13%2E12498211860657%2C52%2E39511316914987?access_token=&steps=true')
    end
  end
  
  describe "GET #is_in_babelsberg" do
    it 'should return false for points outside of babelsberg' do
      expect(subject.is_in_babelsberg '13.2,52.4').to be_truthy
    end

    it 'should return false for points outside of babelsberg' do
      expect(subject.is_in_babelsberg '13.0,52.4').to be_falsey
    end
  end
end
