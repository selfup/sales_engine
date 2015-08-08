class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at

	def initialize(row, customer_repository)
    @id                   = row[:id]
    @first_name           = row[:first_name]
    @last_name            = row[:last_name]
    @created_at           = row[:created_at]
    @updated_at           = row[:updated_at]
    @customer_repository  = customer_repository
  end

end