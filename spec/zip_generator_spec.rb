require 'filemagic'
require File.expand_path '../spec_helper.rb', __FILE__

describe ZipGenerator do
  let(:usernames) { ['bob', 'james', 'smith'] }

  before do
    @data = ZipGenerator.new(usernames).data
  end

  it 'generates data in zip format' do
    fm = FileMagic.new
    expect(fm.buffer(@data)).to include('Zip archive data')
  end

  it "generates a zip with a pdf for every username" do
    pdf_names = []
    Zip::InputStream.open(StringIO.new(@data)) do |io|
      while (entry = io.get_next_entry)
        pdf_names << entry.name.split('.')[0]
      end
    end
    expect(pdf_names).to eq(usernames)
  end
end