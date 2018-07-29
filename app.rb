require 'sinatra'
require 'sinatra/json'
require './services/pdf_generator'
require './services/zip_generator'
require './services/github_api'

get '/' do
  erb :index
end

get '/search' do
  @top_contributors, error = GithubApi::top_contributors(params['repo_url'])
  if error
    json error: error
  else
    erb :contributors
  end
end

get '/download/:number/:username' do |number, username|
  content_type 'application/pdf'
  pdf = PdfGenerator.new(username, number)
  pdf.render
end

get '/download_zip' do
  content_type 'application/zip'
  data = ZipGenerator.new(params['usernames'].split(',')).data
  attachment('diplomas.zip')
  response.write(data)
end