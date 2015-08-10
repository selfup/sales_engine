require_relative 'invoice'
require_relative 'all_repos'

class InvoiceRepository
include AllRepos

  attr_reader :repository, :sales_engine

  def initialize(rows, sales_engine)
    @repository   ||= load_invoices(rows)
    @sales_engine ||= sales_engine
  end

  def load_invoices(rows)
    @repository = Hash.new(0)
    rows.map { |row| @repository[row[:id]] = Invoice.new(row, self) }
    @repository
  end

  def find_by_customer_id(id)
    all.detect{ |customer| customer.customer_id == id }
  end

  def find_by_merchant_id(id)
    all.detect{ |merchant| merchant.merchant_id == id }
  end

  def find_by_status(status_d)
    all.detect{ |status_descriptor| status_descriptor.status == status_d }
  end

  def find_all_by_customer_id(id)
    all.select { |customer| customer.customer_id == id }
  end

  def find_all_by_merchant_id(id)
    all.select { |merchant| merchant.merchant_id == id }
  end

  def find_all_by_status(status_d)
    all.select{ |status_descriptor| status_descriptor.status == status_d }
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

end
