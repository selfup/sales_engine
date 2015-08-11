require 'bigdecimal'
require 'date'

class Merchant
  attr_reader :id, :name, :created_at, :updated_at

	def initialize(row, merchant_repository)
    @id                   = row[:id].to_i
    @name                 = row[:name]
    @created_at           = Date.parse(row[:created_at])
    @updated_at           = Date.parse(row[:updated_at])
    @merchant_repository  = merchant_repository
  end

  def items
    item_repo = @merchant_repository.sales_engine.item_repository
    item_repo.find_all_by_merchant_id(@id)
  end

  def invoices
    invoice_repo = @merchant_repository.sales_engine.invoice_repository
    invoice_repo.find_all_by_merchant_id(@id)
  end

  def revenue(date = nil)
    total_revenue = 0
    invoices.map do |invoice|
      if invoice.success? && (date == nil || date == invoice.created_at)
        total_revenue += invoice_item_revenue(invoice)
      end
    end
    total_revenue * 0.01
  end

  def invoice_item_revenue(invoice)
    inv_item_revenue = invoice.invoice_items.map do |invoice_item|
      invoice_item.revenue
    end
    inv_item_revenue.reduce(:+)
  end

end
