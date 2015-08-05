require 'csv'
require 'pry'
require_relative 'invoice_repository'


class InvoiceLoader

  def load_all(file = "./data/invoices.csv")
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end

end
