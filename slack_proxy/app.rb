require 'sinatra/base'
require 'httparty'
require 'json'

FLUENT_ENDPOINT = ENV['FLUENT_ENDPOINT'] # or rewrite directly

get '/' do
  200
end

post '/slack' do
  converted = {}
  %w|service_id channel_id timestamp token team_id team_domain channel_name user_id user_name text|.map do |key|
    converted[key] = params[key]
  end
  response =
    HTTParty.post(FLUENT_ENDPOINT,
                  body: "json=#{converted.to_json}",
                  options: { headers: { 'Content-Type' => 'application/json' } }
                  )
  logger.error response.body unless response.code == 200

  200
end
