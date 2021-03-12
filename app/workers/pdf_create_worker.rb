class PdfCreateWorker
  include Sidekiq::Worker

  def perform(index)
    pdf = Pdf.create(name: "#{Time.zone.now.to_i}-index-#{index}")
    pdf.file.attach(
      io:           StringIO.new(generate_pdf),
      filename:     "#{pdf.name}.pdf",
      content_type: "application/pdf")
  end

  private

  def generate_pdf
    body_html = ApplicationController.new.render_to_string(partial: 'home/pdf')
    pdf_file = WickedPdf.new.pdf_from_string(
      body_html,
      encoding:    'utf8',
      return_file: true
    )
    pdf_file.read
  end
end
