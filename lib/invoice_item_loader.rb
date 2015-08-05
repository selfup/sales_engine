require 'csv'
require 'pry'
require_relative 'invoice_item_repository'


class InvoiceItemLoader

  def load_all(file = "./data/invoice_items.csv")
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end

end
