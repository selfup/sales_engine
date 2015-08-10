require 'csv'
require_relative 'invoice_repository'


class InvoiceLoader

  def load_all(file)
    if file == ""
      file = "./data/fixtures/invoices_fixtures.csv"
    end
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end

end
