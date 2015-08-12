require 'bigdecimal'
require 'date'

class InvoiceItem
  attr_reader :id, :item_id, :invoice_id, :quantity,
              :unit_price, :created_at, :updated_at

  def initialize(row, invoice_item_repository)
    @id                       = row[:id].to_i
    @item_id                  = row[:item_id].to_i
    @invoice_id               = row[:invoice_id].to_i
    @quantity                 = row[:quantity].to_i
    @unit_price               = BigDecimal.new(row[:unit_price])
    @created_at               = Date.parse(row[:created_at])
    @updated_at               = Date.parse(row[:updated_at])
    @invoice_item_repository  = invoice_item_repository
  end

  def invoice
    invoice_repo = @invoice_item_repository.sales_engine.invoice_repository
    invoice_repo.find_by_id(@invoice_id)
  end

  def item
    item_repo = @invoice_item_repository.sales_engine.item_repository
    item_repo.find_by_id(@item_id)
  end

  def revenue
    BigDecimal.new(@quantity) * BigDecimal.new(@unit_price)
  end

end
