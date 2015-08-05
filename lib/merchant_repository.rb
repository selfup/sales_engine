require_relative 'merchant'

class MerchantRepository

  attr_reader :merchants

  def initialize(rows, sales_engine)
    @merchants  ||= load_merchants(rows)
    @sales_engine = sales_engine
  end

  def load_merchants(rows)
    @merchants = Hash.new(0)
    rows.map { |row| @merchants[row[:id]] = Merchant.new(row, self) }
    @merchants
  end

end
