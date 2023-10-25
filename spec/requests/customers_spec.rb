require 'rails_helper'

RSpec.describe "Customers", type: :request do
  let!(:customer1) { create(:customer, name: 'Customer 1')  }

  context "index" do
    it 'gets all the customers' do
      # THIS TEST HELPED ME to quickly DETECT THE ERROR! request.body!!! 
      get '/customers', params: { format: :json }
      json_response = JSON.parse(response.body)
      expect(json_response[0]["name"]).to eq(customer1.name)
    end
  end
end
