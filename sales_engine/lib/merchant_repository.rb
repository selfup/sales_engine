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

  def most_revenue(top_x)
    merchant_revenue = @repository.values.map do |merchant|
      {merchant => merchant.revenue}
    end

    merchant_revenue.sort!{|m1,m2| m2.values <=> m1.values}
    merchant_revenue[0..top_x - 1].map{|merchant| merchant.keys}.flatten
    # merchant_revenue.sort{|merchant1, merchant2| merchant2 <=> merchant1}
    # merchant_id = @repository.values.map do |merchant_name|
    #   merchant.find_by_name
    # top_merchants = @repository.values.sort do |merchant1, merchant2|
    #   merchant2.revenue <=> merchant1.revenue
    # end
    # top_merchants[0..top_x - 1]
  end

end
