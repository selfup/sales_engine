require 'csv'
require 'pry'
require_relative 'customer_repository'
require_relative 'customer_loader'


class SalesEngine
  attr_reader :customer_repository, :customer_data

  def initialize
    @customer_data = CustomerLoader.new.load_all
  end

  def startup
    binding.pry
    @customer_repository = CustomerRepository.new(@customer_data, self)
    binding.pry
  end

end

p k = SalesEngine.new.startup
