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

end
