class Transaction
  attr_reader :id, :invoice_id, :credit_card_number,
              :credit_card_expiration_date, :result,
              :updated_at, :created_at

	def initialize(row, transaction_repository)
    @id                          = row[:id]
    @invoice_id                  = row[:invoice_id]
    @credit_card_number          = row[:credit_card_number]
    @credit_card_expiration_date = row[:credit_card_expiration_date]
    @result                      = row[:result]
    @created_at                  = row[:created_at]
    @updated_at                  = row[:updated_at]
    @transaction_repository      = transaction_repository
  end

end
