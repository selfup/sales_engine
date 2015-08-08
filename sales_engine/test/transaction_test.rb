require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction.rb'

class TransactionTest < Minitest::Test

	def test_it_initializes_each_column
		file = "./data/fixtures/single_id_transactions.csv"
		transaction_data = CSV.open(file, headers: true, header_converters: :symbol)
		transactions = transaction_data.map { |row| Transaction.new(row, nil) }

		id_result 				        = transactions[0].id
		invoice_id_result         = transactions[0].invoice_id
		credit_card_number_result = transactions[0].credit_card_number
		result_result             = transactions[0].result
		created_at_result         = transactions[0].created_at
		updated_at_result         = transactions[0].updated_at

		assert_equal "1", id_result
		assert_equal "1", invoice_id_result
		assert_equal "4654405418249632", credit_card_number_result
		assert_equal "success", result_result
		assert_equal "2012-03-27 14:54:09 UTC", created_at_result
		assert_equal "2012-03-27 14:54:09 UTC", updated_at_result
	end

end
