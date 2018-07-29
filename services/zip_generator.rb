require 'zip'
require 'tempfile'
require_relative './pdf_generator'

class ZipGenerator
  attr_reader :data

  def initialize(usernames)
    stringio = Zip::OutputStream::write_buffer do |zip|
      usernames.each_with_index do |username, index|
        temp_pdf = Tempfile.new(["#{username}", '.pdf'])

        begin
          temp_pdf.binmode
          temp_prawn_pdf = PdfGenerator.new(username, index+1)
          temp_pdf.write temp_prawn_pdf.render
          temp_pdf.rewind
          zip.put_next_entry("#{username}.pdf")
          zip.print IO.read(temp_pdf.path)
        ensure
          temp_pdf.close(true)
        end
      end
    end
    
    @data = stringio.string
  end
end