require 'http'
require 'uri'
require 'json'

class GithubApi
  API_ENDPOINT = 'https://api.github.com'
  INVALID_LINK_MESSAGE = 'The specified url is not a valid Github repository'.freeze

  def self.top_contributors(repo_url, count = 3)
    if repo_url.match?(/^https:\/\/github\.com\/[a-z0-9\-_.]+\/[a-z0-9\-_.]+$/)
      repo_url_without_host = URI(repo_url).path
      response = authenticate.get("#{API_ENDPOINT}/repos#{repo_url_without_host}/contributors")

      if response.code == 200
        contributors = response.parse[0...count].map { |contributor| contributor['login'] }
        [contributors, nil]
      else
        [[], JSON.parse(response.body)['message']]
      end
    else
      [[], INVALID_LINK_MESSAGE]
    end
  end

  private

  def self.authenticate
    HTTP.basic_auth(user: ENV['GITHUB_USER'], pass: ENV['GITHUB_TOKEN'])
  end
end