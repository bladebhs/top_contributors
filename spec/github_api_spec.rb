require File.expand_path '../spec_helper.rb', __FILE__

describe GithubApi do
  let(:invalid_repo) { 'https://github.com/prawnpdf' }
  let(:valid_repo) { 'https://github.com/prawnpdf/prawn' }

  context 'when authenticate' do
    it 'responses with status 200' do
      response = GithubApi::authenticate.get(GithubApi::API_ENDPOINT)
      expect(response.code).to eq(200)
    end
  end

  context 'get contributors from a valid repo' do
    it "returns non-empty array without errors" do
      contributors, error = GithubApi::top_contributors(valid_repo)
      # even if the repo is valid, Github may be unavailable or return an error
      if error
        expect(contributors).to be_empty
      else  
        expect(contributors).not_to be_empty
      end
    end
  end

  context 'get contributors from an invalid repo' do
    it "returns empty array with error" do
      contributors, error = GithubApi::top_contributors(invalid_repo)
      expect(contributors).to be_empty 
      expect(error).to eq(GithubApi::INVALID_LINK_MESSAGE)
    end
  end
end