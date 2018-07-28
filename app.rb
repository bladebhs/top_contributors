require 'sinatra'
require './services/pdf_generator'
require './services/github_api'

get '/' do
  erb :index
end

get '/search' do
  @top_contributors, @error = GithubApi::top_contributors(params['repo_url'])

  erb :index
end

get '/download/:number/:username' do |number, username|
  content_type 'application/pdf'
  pdf = PdfGenerator.new(username, number)
  pdf.render
end

get '/download_zip' do
  content_type 'application/zip'
end