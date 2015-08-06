require_relative 'item'
require_relative 'all_repos'

class ItemRepository
include AllRepos

  attr_reader :repository

  def initialize(rows, sales_engine)
    @repository = load_items(rows)
    @sales_engine = sales_engine
  end

  def load_items(rows)
    @repository = Hash.new(0)
    rows.map { |row| @repository[row[:id]] = Item.new(row, self) }
    @repository
  end

  def find_by_item_name(item_name)
    all.detect{|item| item.name.downcase == item_name.downcase}
  end

  def find_all_by_item_name(item_name)
    all.select{|item| item.name.downcase == item_name.downcase}
  end

  def find_by_merchant_id(id)
    all.detect{ |merchant| merchant.merchant_id == id }
  end

  def find_all_by_merchant_id(id)
    all.select { |merchant| merchant.merchant_id == id }
  end

end
