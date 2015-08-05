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
		customer_id_result = invoices[0].first_name
		merchant_id_result = invoices[0].last_name
		status_result      = invoices[0].created_at
		created_at_result  = invoices[0].updated_at
		updated_at_result  = invoices[0].created_at

		assert_equal "1", id_result
		assert_equal "Joey", customer_id_result
		assert_equal "Ondricka", merchant_id_result
		assert_equal "2012-03-27 14:54:09 UTC", status_result
		assert_equal "2012-03-27 14:54:09 UTC", created_at_result
	end

end
