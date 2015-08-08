require 'csv'
require 'pry'
require_relative 'invoice_repository'


class ItemLoader

  def load_all(test_file = false)
    if test_file
      file = "./data/fixtures/items_fixtures.csv"
    else
      file = "./data/items.csv"
    end
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end

end
