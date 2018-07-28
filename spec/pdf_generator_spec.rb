require File.expand_path '../spec_helper.rb', __FILE__
require 'pdf/inspector'

describe PdfGenerator do
  let(:username) { 'test' }
  let(:number)     { Random.rand(100) }

  it "generates a pdf with the specified username and number" do
    pdf = PdfGenerator.new(username, number).render
    text_analysis = PDF::Inspector::Text.analyze(pdf)
    expect(text_analysis.strings).to include("PDF ##{number.to_s}", username)
  end
end