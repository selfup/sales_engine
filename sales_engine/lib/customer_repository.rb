require_relative 'customer'
require_relative 'all_repos'

class CustomerRepository
include AllRepos

  attr_reader :repository, :sales_engine

  def initialize(rows, sales_engine)
    @repository   ||= load_customers(rows)
    @sales_engine ||= sales_engine
  end

  def load_customers(rows)
    @repository = Hash.new(0)
    rows.map { |row| @repository[row[:id]] = Customer.new(row, self) }
    @repository
  end

  def find_by_first_name(name)
    all.detect{|customer| customer.first_name.downcase == name.downcase}
  end

  def find_by_last_name(name)
    all.detect{|customer| customer.last_name.downcase == name.downcase}
  end

  def find_all_by_first_name(name)
    all.select { |customer| customer.first_name.downcase == name.downcase }
  end

  def find_all_by_last_name(name)
    all.select { |customer| customer.last_name.downcase == name.downcase }
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

end
