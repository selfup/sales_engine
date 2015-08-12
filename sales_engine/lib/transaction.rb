require 'date'

class Transaction
  attr_reader :id, :invoice_id, :credit_card_number,
              :credit_card_expiration_date, :result,
              :updated_at, :created_at

  def initialize(row, transaction_repository)
    @id                          = row[:id].to_i
    @invoice_id                  = row[:invoice_id].to_i
    @credit_card_number          = row[:credit_card_number]
    @credit_card_expiration_date = row[:credit_card_expiration_date]
    @result                      = row[:result]
    @created_at                  = Date.parse(row[:created_at])
    @updated_at                  = Date.parse(row[:updated_at])
    @transaction_repository      = transaction_repository
  end

  def invoice
    invoice_repo = @transaction_repository.sales_engine.invoice_repository
    invoice_repo.find_by_id(@invoice_id)
  end

  def success?
    @result == "success"
  end

end
