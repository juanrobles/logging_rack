require 'rails_helper'
require "rack/test"

class FakeJsonApp
  def call(env)
    mock_response = Rack::MockResponse.new(
      200,
      { "Content-Type" => "application/json" },
      ["{\"id\":1,\"name\":\"Jake\"}"] 
    )
    [200, { "Content-Type" => "application/json" }, mock_response]
  end
end

RSpec.describe "LogRequestMiddleware" do
  include Rack::Test::Methods
  
  context "logging JSON data" do
    let(:app) { FakeJsonApp.new }
    let(:logger) { LogRequestMiddleware.new(app) }
    let(:request) { Rack::MockRequest.env_for("http://localhost:3000/customers") }

    it 'creates a Log record when calling index' do
      expect { logger.call(request) }.to change(Log, :count).by(1)
    end
  end
end
