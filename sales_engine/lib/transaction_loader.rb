require 'csv'

class TransactionLoader

  def load_all(test_file = false)
    if test_file
      file = "./data/fixtures/transactions_items_fixtures.csv"
    else
      file = "./data/transactions.csv"
    end
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end


end
