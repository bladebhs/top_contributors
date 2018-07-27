require 'sinatra'
require 'http'
require 'uri'

API_ENDPOINT = 'https://api.github.com'

get '/' do
  erb :index
end

get '/search' do
  repo_url = URI(params['repo_url']).path
  response = HTTP.get("#{API_ENDPOINT}/repos#{repo_url}/contributors")
  @top_contributors = response.parse[0..2].map { |contributor| contributor['login'] }

  erb :index
end
