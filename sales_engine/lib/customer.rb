require 'date'

class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at

  def initialize(row, customer_repository)
    @id                   = row[:id].to_i
    @first_name           = row[:first_name]
    @last_name            = row[:last_name]
    @created_at           = Date.parse(row[:created_at])
    @updated_at           = Date.parse(row[:updated_at])
    @customer_repository  = customer_repository
  end

  def invoices
    invoice_repo = @customer_repository.sales_engine.invoice_repository
    invoice_repo.find_all_by_customer_id(@id)
  end

  def transactions
    inv_repo = @customer_repository.sales_engine.invoice_repository
    customer_invoices = inv_repo.find_all_by_customer_id(@id)
    customer_transactions = customer_invoices.map do |invoice|
      invoice.transactions
    end
    customer_transactions.flatten
  end

  def favorite_merchant
    merchant_count = Hash.new(0)
    invoices.map do |invoice|
      merchant_count[invoice.merchant_id] += 1
    end
    id = merchant_count.key(merchant_count.values.max)
    fm = @customer_repository.sales_engine.merchant_repository.find_by_id(id)
    fm
  end


end
