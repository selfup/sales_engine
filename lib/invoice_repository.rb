require_relative 'invoice'
require_relative 'all_repos'

class InvoiceRepository
include AllRepos

  attr_reader :repository

  def initialize(rows, sales_engine)
    @repository = load_invoices(rows)
    @sales_engine = sales_engine
  end

  def load_invoices(rows)
    @repository = Hash.new(0)
    rows.map { |row| @repository[row[:id]] = Invoice.new(row, self) }
    @repository
  end

  def find_by_customer_id(id)
    all.detect{|customer| customer.customer_id == id}
  end

end
