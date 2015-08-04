require 'csv'
require 'pry'
require_relative 'customer_repository'


class CustomerLoader

  def load_all(file = "./data/customers.csv")
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end

end
