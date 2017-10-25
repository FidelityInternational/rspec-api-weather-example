require './spec_helper.rb'

describe 'Start page' do
  it 'Start page ok' do
    get '/'
    expect(last_response).to be_ok
  end

  it 'Start content' do
    get '/'
    expect(last_response.body).to eq('weather_service')
  end
end

describe '/temp' do
  let(:valid_response) do
    File.read('./fixtures/api.worldweatheronline.com_london.json')
  end

  it 'Returns the temperature' do
    stub_request(:get, WORLDWEATHERONLINE_WEATHER_ENDPOINT)
      .with(query: hash_including('key' => WORLDWEATHERONLINE_API_KEY))
      .to_return(status: 200, body: valid_response, headers: {})

    get '/temp'
    expect(last_response).to be_ok
    expect { JSON.parse(last_response.body) }.to_not raise_error
    jdata = JSON.parse(last_response.body)
    expect(jdata).to have_key('temp')
    expect(jdata['temp']).to match(/^[0-9]+$/)
  end

  it 'Returns error if the key is invalid' do
    stub_request(:get, WORLDWEATHERONLINE_WEATHER_ENDPOINT)
      .with(query: hash_including({}))
      .to_return(status: [401, 'API key is invalid'])

    get '/temp'
    expect(last_response).to_not be_ok
    expect(last_response.status).to be(500)
  end
end
