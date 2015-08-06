require_relative 'customer'
require_relative 'query'

class CustomerRepository
include Query

  attr_reader :repository

  def initialize(rows, sales_engine)
    @repository  ||= load_customers(rows)
    @sales_engine = sales_engine
  end

  def load_customers(rows)
    @repository = Hash.new(0)
    rows.map { |row| @repository[row[:id]] = Customer.new(row, self) }
    @repository
  end

end
