require_relative 'merchant'
require_relative 'all_repos'

class MerchantRepository

  include AllRepos

  attr_reader :repository, :sales_engine

  def initialize(rows, sales_engine)
    @repository   ||= load_merchants(rows)
    @sales_engine ||= sales_engine
  end

  def load_merchants(rows)
    @repository = Hash.new(0)
    rows.map { |row| @repository[row[:id].to_i] = Merchant.new(row, self) }
    @repository
  end

  def find_by_name(merchant_name)
    all.detect{|merchant| merchant.name.downcase == merchant_name.downcase}
  end

  def find_all_by_name(merchant_name)
    all.select{|merchant| merchant.name.downcase == merchant_name.downcase}
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

end
