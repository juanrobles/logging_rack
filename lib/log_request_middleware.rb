class LogRequestMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)
    request = Rack::Request.new(env)
    request_body = request.body.read
    log_request_and_response!(
      request: request_body, 
      headers: env["HTTP_AUTHORIZATION"], 
      url: request.path, 
      # CHANGE this line to fix it
      response: response.first
      # response: response.body
    )

    [status, headers, response]
  end

  def log_request_and_response!(request:, headers:, url:, response:)
    return if ['swagger', 'favoicon.ico'].include?(url)
    request = JSON.parse(request) unless request.empty?
    response = JSON.parse(response) unless response.empty?
    Log.create!(
      request: request,
      headers: headers,
      url: url,
      response: response
    )
  end
end