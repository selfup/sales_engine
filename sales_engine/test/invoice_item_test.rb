require 'csv'
require 'date'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item.rb'
require './lib/sales_engine'

class InvoiceItemTest < Minitest::Test

	def test_it_initializes_each_column
		csv = "./data/fixtures/single_id_invoice_item.csv"
		invoice_item_data = CSV.open(csv, headers: true, header_converters: :symbol)
		invoice_items = invoice_item_data.map { |row| InvoiceItem.new(row, nil) }

		id_result 				= invoice_items[0].id
		item_id_result    = invoice_items[0].item_id
		invoice_id_result = invoice_items[0].invoice_id
		quantity_result   = invoice_items[0].quantity
		unit_price_result = invoice_items[0].unit_price
    created_at_result = invoice_items[0].created_at
    updated_at_result = invoice_items[0].updated_at

    assert_equal 1, id_result
		assert_equal 539, item_id_result
		assert_equal 1, invoice_id_result
		assert_equal 5, quantity_result
		assert_equal 13635, unit_price_result
		assert_equal Date.parse("2012-03-27 14:54:09 UTC"), created_at_result
    assert_equal Date.parse("2012-03-27 14:54:09 UTC"), updated_at_result
	end

	def test_it_returns_an_invoice_instance_associated_with_invoice_items
		engine = SalesEngine.new("test", true)
		engine.startup

		result = engine.invoice_item_repository.repository[9].invoice

		assert_equal 2, result.id
		assert_equal Invoice, result.class
	end

	def test_it_returns_an_item_instance_associated_with_invoice_items
		engine = SalesEngine.new("test", true)
		engine.startup

		result = engine.invoice_item_repository.repository[9].item

		assert_equal 99, result.id
		assert_equal Item, result.class
	end

	def test_it_returns_an_invoice_items_revenue
		engine = SalesEngine.new("test", true)
		engine.startup

		result = engine.invoice_item_repository.repository[1].revenue

		assert_equal (5 * 13635), result
	end


end
