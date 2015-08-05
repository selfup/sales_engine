require_relative 'invoice_item'

class InvoiceItemRepository

  attr_reader :invoice_items

  def initialize(rows, sales_engine)
    @all = load_invoice_items(rows)
  end

  def load_invoice_items(rows)
    rows.map { |row| InvoiceItem.new(row, self) }
  end

end
