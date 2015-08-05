class Transaction
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at

	def initialize(row, transaction_repository)
    @id                   = row[:id]
    @first_name           = row[:first_name]
    @last_name            = row[:last_name]
    @created_at           = row[:created_at]
    @updated_at           = row[:updated_at]
    @transaction_repository  = transaction_repository
  end

end
