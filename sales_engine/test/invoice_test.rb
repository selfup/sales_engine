require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice.rb'
require './lib/sales_engine'

class InvoiceTest < Minitest::Test

	def test_it_initializes_each_column
		file = "./data/fixtures/single_id_invoice.csv"
		invoice_data = CSV.open(file, headers: true, header_converters: :symbol)
		invoices = invoice_data.map { |row| Invoice.new(row, nil) }

		id_result 				 = invoices[0].id
		customer_id_result = invoices[0].customer_id
		merchant_id_result = invoices[0].merchant_id
		status_result      = invoices[0].status
		created_at_result  = invoices[0].created_at
		updated_at_result  = invoices[0].updated_at

		assert_equal "1", id_result
		assert_equal "1", customer_id_result
		assert_equal "26", merchant_id_result
		assert_equal "shipped", status_result
		assert_equal "2012-03-25 09:54:09 UTC", created_at_result
		assert_equal "2012-03-25 09:54:09 UTC", updated_at_result
	end

	def test_it_returns_an_invoice_instance_associated_with_transactions
		engine = SalesEngine.new(true)
		engine.startup

		result = engine.invoice_repository.repository["10"].transactions

		assert_equal 2, result.length
		assert_equal "9", result[0].id
		assert_equal "10", result[1].id
	end

	def test_it_returns_an_invoice_instance_associated_with_invoice_items
		engine = SalesEngine.new(true)
		engine.startup

		result = engine.invoice_repository.repository["2"].invoice_items

		assert_equal 2, result.length
		assert_equal "9", result[0].id
		assert_equal "10", result[1].id
	end

end
