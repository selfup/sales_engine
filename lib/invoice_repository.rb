require_relative 'invoice'

class InvoiceRepository

  attr_reader :all

  def initialize(rows, sales_engine)
    @all = load_invoices(rows)
  end

  def load_invoices(rows)
    rows.map { |row| Invoice.new(row, self) }
  end

end
