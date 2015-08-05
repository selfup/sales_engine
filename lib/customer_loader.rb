require 'csv'
require 'pry'

class CustomerLoader

  def load_all(file = "./data/customers.csv")
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end

end
