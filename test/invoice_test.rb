require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice.rb'

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

end
