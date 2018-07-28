require 'prawn'

class PdfGenerator
  include Prawn::View

  def initialize(username, number)
    line_width 10
    stroke_color '000000'
    stroke_bounds

    formatted_text([
      { text: "PDF ##{number}\n", size: 64 },
      { text: "The award goes to\n", size: 32 },
      { text: "#{username}", size: 28 }],
      align: :center, valign: :center, leading: 50)
  end
end
