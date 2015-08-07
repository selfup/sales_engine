require_relative 'invoice_item'
require_relative 'all_repos'

class InvoiceItemRepository
include AllRepos

  attr_reader :repository

  def initialize(rows, sales_engine)
    @repository  ||= load_invoice_items(rows)
    @sales_engine = sales_engine
  end

  def load_invoice_items(rows)
    @repository = Hash.new(0)
    rows.map { |row| @repository[row[:id]] = InvoiceItem.new(row, self) }
    @repository
  end

  def find_by_item_id(id)
    all.detect{ |customer| customer.customer_id == id }
  end

  def find_by_invoice_id(id)
    all.detect{ |merchant| merchant.merchant_id == id }
  end

  def find_by_unit_price(status_d)
    all.detect{ |status_descriptor| status_descriptor.status == status_d }
  end

  def find_by_quantity(status_d)
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

end
