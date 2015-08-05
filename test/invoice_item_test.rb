require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item.rb'

class InvoiceItemTest < Minitest::Test

	def test_it_initializes_each_column
		file = "./data/fixtures/single_id_invoice_items.csv"
		invoice_item_data = CSV.open(file, headers: true, header_converters: :symbol)
		invoice_items = invoice_data.map { |row| Invoice.new(row, nil) }

		id_result 				= invoice_items[0].id
		item_id_result = invoice_items[0].item_id
		invoice_id_result  = invoice_items[0].invoice_id
		quantity_result = invoice_items[0].quantity
		unit_price_result = invoice_items[0].unit_price
    created_at_result = invoice_items[0].created_at
    updated_at_result = invoice_items[0].updated_at

    assert_equal "1", id_result
		assert_equal "539", item_id_result
		assert_equal "1", invoice_id_result
		assert_equal "5", quantity_result
		assert_equal "13635", unit_price_result
		assert_equal "2012-03-27 14:54:09 UTC", created_at_result
    assert_equal "2012-03-27 14:54:09 UTC", updated_at_result
	end

end
