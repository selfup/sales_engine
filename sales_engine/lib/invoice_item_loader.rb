require 'csv'

class InvoiceItemLoader

  def load_all(test_file = false)
    if test_file
      file = "./data/fixtures/invoices_items_fixtures.csv"
    else
      file = "./data/invoice_items.csv"
    end
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end

end