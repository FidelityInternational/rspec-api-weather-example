require 'sinatra'
require 'net/http'
require 'uri'
require 'json'

WORLDWEATHERONLINE_WEATHER_ENDPOINT = 'http://api.worldweatheronline.com/premium/v1/weather.ashx'.freeze
WORLDWEATHERONLINE_API_KEY = ENV['WORLDWEATHERONLINE_API_KEY'] || 'undefined'

get '/' do
  'weather_service'
end

get '/temp' do
  uri = URI(WORLDWEATHERONLINE_WEATHER_ENDPOINT)
  params = {
    key: WORLDWEATHERONLINE_API_KEY,
    q: 'London',
    format: 'json'
  }
  uri.query = URI.encode_www_form(params)

  res = Net::HTTP.get_response(uri)

  raise "Error calling #{WORLDWEATHERONLINE_WEATHER_ENDPOINT}: #{res.body}" \
    unless res.is_a?(Net::HTTPSuccess)

  jdata = JSON.parse(res.body)
  temp = jdata['data']['current_condition'][0]['temp_C']

  raise 'Unable to find current temp in response' if temp.nil?

  body JSON.dump('temp' => temp)
end
