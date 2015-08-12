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

  def item_revenue(item_id)
    inv_it = @sales_engine.invoice_item_repository.find_all_by_item_id(item_id)
    inv_it.reduce(0){|sum,merchant| sum + merchant.revenue}
  end

  def most_revenue(top_x)
    items = @repository.values.map do |item|
      {item => item_revenue(item.id)}
    end
    items.sort!{|i1,i2| i2.values <=> i1.values}
    items[0..top_x - 1].map{|item| item.keys}.flatten
  end
#look into refactoring methods below for increasing speed
  def item_quantity(item_id)
    inv_it = @sales_engine.invoice_item_repository.find_all_by_item_id(item_id)
    invoice_quantity(inv_it)
  end

  def invoice_quantity(inv_it)
    count = 0
    inv_it.map do |inv_item|
      invoice_repo = @sales_engine.invoice_repository
      success = invoice_repo.find_by_id(inv_item.invoice_id).success?
        count += inv_item.quantity if success
    end
    count
  end

  def most_items(top_x)
    items = @repository.values.map do |item|
      {item => item_quantity(item.id)}
    end
    items.sort!{|i1,i2| i2.values <=> i1.values}
    items[0..top_x - 1].map{|item| item.keys}.flatten
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

end
