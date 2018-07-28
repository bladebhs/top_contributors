require File.expand_path '../spec_helper.rb', __FILE__

describe '/download_zip' do
  it 'returns a response in zip format' do
    get "/download_zip"
    expect(last_response.headers['Content-Type']).to eq 'application/zip'
  end
end