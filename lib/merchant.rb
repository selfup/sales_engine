class Merchant
  attr_reader :id, :name, :created_at, :updated_at

	def initialize(row, merchant_repository)
    @id                   = row[:id]
    @name                 = row[:name]
    @created_at           = row[:created_at]
    @updated_at           = row[:updated_at]
    @merchant_repository  = merchant_repository
  end

end
