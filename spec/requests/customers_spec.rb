require 'rails_helper'

RSpec.describe "Customers", type: :request do
  let!(:customer1) { create(:customer, name: 'Customer 1')  }

  context "index" do
    it 'gets all the customers' do
      # This test helped me detect the error! request.body!!! 
      get '/customers', params: { format: :json }
      json_response = JSON.parse(response.body)
      expect(json_response[0]["name"]).to eq(customer1.name)
    end
  end
end
