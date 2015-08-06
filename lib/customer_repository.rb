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

  def all
    @customers.values
  end

  def random
    @customers.values.sample
  end

  def find_by_id(id)
    @customers[id]
  end

  def find_by_first_name(name)
    customer = all.select{|value| value.first_name.downcase == name.downcase}
    customer[0]
  end

  #def find_by_last_name
  #end

end
