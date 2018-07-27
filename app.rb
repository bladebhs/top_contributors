require 'sinatra'
require 'http'
require 'uri'
require './pdf_generator'

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

get '/download/:number/:username' do |number, username|
  content_type 'application/pdf'
  pdf = PdfGenerator.new(username, number)
  pdf.render
end