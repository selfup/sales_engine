require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant.rb'
require './lib/sales_engine.rb'

class MerchantTest < Minitest::Test

	def test_it_initializes_each_column
		file = "./data/fixtures/single_id_merchant.csv"
		merchant_data = CSV.open(file, headers: true, header_converters: :symbol)
		merchants = merchant_data.map { |row| Merchant.new(row, nil) }

		id_result 				= merchants[0].id
		name_result       = merchants[0].name
		created_at_result = merchants[0].created_at
		updated_at_result = merchants[0].updated_at

		assert_equal "1", id_result
		assert_equal "Schroeder-Jerde", name_result
		assert_equal "2012-03-27 14:53:59 UTC", created_at_result
		assert_equal "2012-03-27 14:53:59 UTC", updated_at_result
	end

	def test_it_returns_a_collection_of_item_instances_associated_with_merchant
		engine = SalesEngine.new(true)
		engine.startup

		result = engine.merchant_repository.repository["1"].items
		result = result.map { |item| item.id }

		assert_equal 11, result.length
    assert_equal "1", result[0]
    assert_equal "2", result[1]
    assert_equal "3", result[2]
    assert_equal "4", result[3]
    assert_equal "5", result[4]
    assert_equal "6", result[5]
    assert_equal "72", result[6]
    assert_equal "8", result[7]
    assert_equal "9", result[8]
    assert_equal "99", result[9]
    assert_equal "11", result[10]
	end

	def test_it_returns_a_collection_of_invoice_instances_associated_with_merchant
		engine = SalesEngine.new(true)
		engine.startup
		result = engine.merchant_repository.repository["1"].invoices
		result = result.map { |invoice| invoice.id }

		assert_equal 2, result.length
		assert_equal "2", result[0]
		assert_equal "11", result[1]
	end


	def test_it_returns_the_total_revenue_across_all_transactions
		engine = SalesEngine.new(true)
		engine.startup
		result = engine.merchant_repository.repository["1"].revenue

		assert_equal ((6 * 76941) + (4 * 1859)), result
	end

	def test_it_returns_a_revenue_of_zero
		engine = SalesEngine.new(true)
		engine.startup
		result = engine.merchant_repository.repository["2"].revenue

		assert_equal 0, result
	end

end
