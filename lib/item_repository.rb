require_relative 'invoice'

class ItemRepository

  attr_reader :all

  def initialize(rows, sales_engine)
    @all = load_items(rows)
  end

  def load_items(rows)
    rows.map { |row| Invoice.new(row, self) }
  end

end
