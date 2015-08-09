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

end
