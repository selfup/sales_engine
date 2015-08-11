require 'csv'

class InvoiceItemLoader

  def load_all(file)
    # if file == ""
    #   file = "./data/fixtures/invoices_items_fixtures.csv"
    # end
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end

end
