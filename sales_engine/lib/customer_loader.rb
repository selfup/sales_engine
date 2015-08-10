require 'csv'

class CustomerLoader

  def load_all(file)
    if file == ""
      file = "./data/fixtures/customers_fixtures.csv"
    end
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end

end
