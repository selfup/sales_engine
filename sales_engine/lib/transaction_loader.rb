require 'csv'

class TransactionLoader

  def load_all(file)
    # if file == ""
    #   file = "./data/fixtures/transactions_items_fixtures.csv"
    # end
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end


end
