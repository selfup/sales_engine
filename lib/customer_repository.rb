require_relative 'customer'

class CustomerRepository

  attr_reader :all

  def initialize(rows, sales_engine)
    @all = load_customers(rows)
  end

  def load_customers(rows)
    rows.map { |row| Customer.new(row, self) }
  end
  # bob.customer_repo
end
