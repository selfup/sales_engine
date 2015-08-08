require 'csv'
require_relative 'invoice_repository'


class InvoiceLoader

  def load_all(test_file = false)
    if test_file
      file = "./data/fixtures/invoices_fixtures.csv"
    else
      file = "./data/invoices.csv"
    end
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end

end
