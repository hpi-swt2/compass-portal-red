require 'rails_helper'

RSpec.describe IndoorController, type: :controller do
#http://localhost:3000/directions/walking/
#13p132964372634888%2C52p39388888702635;13p12498211860657%2C52p39511316914987
#?overview=false&alternatives=true&steps=true
  describe "GET #directions" do
    before do
      request.params[:overview] = 'false'
      request.params[:alternativs] = 'true'
      request.params[:steps] = 'true'
    end
    # test route in one test to prevent excessive API calls
    it 'should return a route' do
      request.params[:coordinates] = '13p132964372634888%2C52p39388888702635;13p12498211860657%2C52p39511316914987' # main building to campus III
      get :directions
      expect(response).to have_http_status(200)
      parsed_body = JSON.parse(response.body)
    end
    it 'should block requests from or to outside HPI' do
      request.params[:coordinates] = '53p554725%2C9p994913;'
    end 
  end
  decribe "GET #url" do
  end
  describe "GET #is_in_babelsberg" do
  end
end
