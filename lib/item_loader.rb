require 'csv'
require 'pry'
require_relative 'invoice_repository'


class ItemLoader

  def load_all(file = "./data/items.csv")
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end

end
