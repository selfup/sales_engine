require_relative 'merchant'
require_relative 'query'

class MerchantRepository

  include Query

  attr_reader :repository

  def initialize(rows, sales_engine)
    @repository  ||= load_merchants(rows)
    @sales_engine = sales_engine
  end

  def load_merchants(rows)
    @repository = Hash.new(0)
    rows.map { |row| @repository[row[:id]] = Merchant.new(row, self) }
    @repository
  end

end
