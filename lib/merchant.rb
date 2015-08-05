class Merchant
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at

	def initialize(row, merchant_repository)
    @id                   = row[:id]
    @first_name           = row[:first_name]
    @last_name            = row[:last_name]
    @created_at           = row[:created_at]
    @updated_at           = row[:updated_at]
    @merchant_repository  = merchant_repository
  end

end
