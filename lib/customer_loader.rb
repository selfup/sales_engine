require 'csv'

class CustomerLoader

  def load_all(test_file = false)
    if test_file.true?
      file = "./data/fixtures/customers_fixtures.csv"
    else
      file = "./data/customers.csv"
    end
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end

end
