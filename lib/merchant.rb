class Merchant
  attr_reader :id, :name, :created_at, :updated_at

	def initialize(row, merchant_repository)
    @id                   = row[:id]
    @name                 = row[:name]
    @created_at           = row[:created_at]
    @updated_at           = row[:updated_at]
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
end
