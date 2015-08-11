require 'csv'

class MerchantLoader

  def load_all(file, test_file = false)
    if test_file
      file = "./data/fixtures/merchants_fixtures.csv"
    end
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end

end
