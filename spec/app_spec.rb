require File.expand_path '../spec_helper.rb', __FILE__

describe 'the main page' do
  let(:invalid_repo) { 'https://github.com/prawnpdf' }
  let(:valid_repo) { 'https://github.com/prawnpdf/prawn' }

  before :each do
    visit '/'
  end

  it 'contains the form' do
    expect(page).to have_selector('form')
  end

  it 'contains the search button' do
    expect(page.find('button')).to have_content('Search')
  end

  context 'when search for an invalid repo' do
    before do
      fill_in 'repo_url', with: invalid_repo
      click_button 'Search'
    end

    it 'contains an error message' do
      expect(page).to have_selector('.error')
      expect(page).to have_content(GithubApi::INVALID_LINK_MESSAGE)
    end
  end

  context 'when search for a valid repo' do
    before do
      fill_in 'repo_url', with: valid_repo
      click_button 'Search'
    end
    
    it 'contains the header' do
      expect(page.find('h2')).to have_content('Results') unless page.has_selector?('.error')
    end

    it 'contains the table with one to three rows' do
      unless page.has_selector?('.error')
        expect(page).to have_selector('table')
        expect(page).to have_css("table tr", between: 1..3)
      end
    end

    it 'contains a download pdf link' do
      unless page.has_selector?('.error')
        expect(page.find('table')).to have_link('download pdf', href: /\/download\/[1-9]+\/[a-z]+/)
      end
    end

    it 'contains a download zip link' do
      unless page.has_selector?('.error')
        expect(page).to have_link('download zip', href: '/download_zip')
      end
    end
  end
end