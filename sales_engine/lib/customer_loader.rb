require 'csv'

class CustomerLoader

  def load_all(file)
    # if file == "data/"
    #   file = "data/customers.csv"
    # end
    data = CSV.open(file, headers: true, header_converters: :symbol)
  end

end
