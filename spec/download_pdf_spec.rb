require File.expand_path '../spec_helper.rb', __FILE__

describe '/download/:number/:username' do
  it 'returns a response in pdf format' do
    get "/download/1/test"
    expect(last_response.headers['Content-Type']).to eq 'application/pdf'
  end
end