require 'csv'

class MerchantLoader

  def load_all(file)
    if file == ""
      file = "./data/fixtures/merchants_fixtures.csv"
    end
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end

end
