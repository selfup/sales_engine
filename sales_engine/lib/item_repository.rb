require_relative 'item'
require_relative 'all_repos'

class ItemRepository
include AllRepos

  attr_reader :repository, :sales_engine

  def initialize(rows, sales_engine)
    @repository   ||= load_items(rows)
    @sales_engine ||= sales_engine
  end

  def load_items(rows)
    @repository = Hash.new(0)
    rows.map { |row| @repository[row[:id].to_i] = Item.new(row, self) }
    @repository
  end

  def find_by_name(name)
    all.detect{|item| item.name.downcase == name.downcase}
  end

  def find_by_merchant_id(id)
    all.detect{ |merchant| merchant.merchant_id == id }
  end

  def find_by_description(description_d)
    all.detect{ |description_of| description_of.description == description_d }
  end

  def find_by_unit_price(price)
    all.detect{ |pricing| pricing.unit_price * 0.01 == price }
  end

  def find_all_by_name(name)
    all.select{|item| item.name.downcase == name.downcase}
  end

  def find_all_by_merchant_id(id)
    all.select { |merchant| merchant.merchant_id == id }
  end

  def find_all_by_description(description_d)
    all.select{ |description_of| description_of.description == description_d }
  end

  def find_all_by_unit_price(price)
    all.select{ |pricing| pricing.unit_price == price }
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

end
