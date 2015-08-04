require_relative 'customer'

class CustomerRepository

  attr_reader :customers

  def initialize(rows, sales_engine)
    @customers  ||= load_customers(rows)
    @sales_engine = sales_engine
  end

  def load_customers(rows)
    @customers = Hash.new(0)
    rows.map { |row| @customers[row[:id]] = Customer.new(row, self) }
    @customers
  end

end
