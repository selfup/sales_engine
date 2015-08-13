require_relative 'invoice_item'
require_relative 'all_repos'

class InvoiceItemRepository
  include AllRepos

  attr_reader :repository, :sales_engine

  def initialize(rows, sales_engine)
    @repository   ||= load_invoice_items(rows)
    @sales_engine ||= sales_engine
  end

  def load_invoice_items(rows)
    @repository = Hash.new(0)
    rows.map { |row| @repository[row[:id].to_i] = InvoiceItem.new(row, self) }
    @repository
  end

  def create_new_inv_item(items, invoice_id)
    items.map do |item|
      id = @repository.values.length + 1
      row = {:id => id, :item_id => item.id, :invoice_id => invoice_id,
             :quantity => 1, :unit_price => item.unit_price,
             :created_at => Time.new().to_s, :updated_at => Time.new().to_s}
    item = InvoiceItem.new(row, self)
    @repository[id] = item
    end
  end

  def find_by_item_id(id)
    all.detect{ |item| item.item_id == id }
  end

  def find_all_by_item_id(id)
    all.select{ |item| item.item_id == id }
  end

  def find_by_invoice_id(id)
    all.detect{ |item| item.invoice_id == id }
  end

  def find_all_by_invoice_id(id)
    all.select{ |item| item.invoice_id == id }
  end

  def find_by_quantity(quantity)
    all.detect{ |item| item.quantity == quantity }
  end

  def find_all_by_quantity(quantity)
    all.select{ |item| item.quantity == quantity }
  end

  def find_by_unit_price(price)
    all.detect{ |item| item.unit_price == price }
  end

  def find_all_by_unit_price(price)
    all.select{ |item| item.unit_price == price }
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

end
