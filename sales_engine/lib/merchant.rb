require 'bigdecimal'
require 'date'

class Merchant
  attr_reader :id, :name, :created_at, :updated_at

	def initialize(row, merchant_repository)
    @id                   = row[:id].to_i
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

  #Find Invoice_ids that match with merchant
  #Find transactions with matching Invoice_ids
  # def find_transaction_invoices
  #   transactions = invoices.map do |invoice|
  #     invoice.transactions[@id].success?
  #   end
  # end

  # def items
  #   transactions = @merchant_repository.sales_engine.transaction_repository
  #   inv_items = transactions.find_all_by_invoice_id(@id)
  #   items = inv_items.map { |inv_item| inv_item.item }
  # end

  #Check if transaction with Invoice_id is successful
    #If transaction is successful calculate revenue

  #make the date a date object

  def revenue
    total_revenue = 0
    invoices.map do |invoice|
      if invoice.success?
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
