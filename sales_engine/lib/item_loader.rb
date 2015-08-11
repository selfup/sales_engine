require 'csv'
require_relative 'invoice_repository'


class ItemLoader

  def load_all(file, test_file = false)
    if test_file
      file = "./data/fixtures/items_fixtures.csv"
    end
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end

end
