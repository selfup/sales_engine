require 'csv'
require 'pry'
require_relative 'invoice_item_repository'


class InvoiceItemLoader

  def load_all(test_file = false)
    if test_file.true?
      file = "./data/fixtures/invoice_items_fixtures.csv"
    else
      file = "./data/invoice_items.csv"
    end
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end

end
