require 'csv'
require 'pry'
require_relative 'customer_repository'


class SalesEngine
  attr_reader :customer_repository

  def startup
    file = "./data/customers.csv"
    data = CSV.open(file, headers: true, header_converters: :symbol)
    @customer_repository = CustomerRepository.new(data)
    binding.pry
  end

end

k = SalesEngine.new.startup
