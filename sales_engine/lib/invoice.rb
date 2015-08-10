class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status,
              :created_at, :updated_at, :invoice_repository

	def initialize(params, invoice_repository)
    @id                  = params[:id]
    @customer_id         = params[:customer_id]
    @merchant_id         = params[:merchant_id]
    @status              = params[:status]
    @created_at          = params[:created_at]
    @updated_at          = params[:updated_at]
    @invoice_repository  = invoice_repository
  end

  def transactions
    transaction_repo = @invoice_repository.sales_engine.transaction_repository
    transaction_repo.find_all_by_invoice_id(@id)
  end

  def invoice_items
    inv_items_repo = @invoice_repository.sales_engine.invoice_item_repository
    inv_items_repo.find_all_by_invoice_id(@id)
  end

  def items
    inv_items_repo = @invoice_repository.sales_engine.invoice_item_repository
    inv_items = inv_items_repo.find_all_by_invoice_id(@id)
    items = inv_items.map { |inv_item| inv_item.item }
  end

  def customer
    customer_repo = @invoice_repository.sales_engine.customer_repository
    customer_repo.find_by_id(@customer_id)
  end

  def merchant
    merchant_repo = @invoice_repository.sales_engine.merchant_repository
    merchant_repo.find_by_id(@merchant_id)
  end

  def success?
    transactions.any?{|transaction| transaction.success?}
  end

end
