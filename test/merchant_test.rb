require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant.rb'

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

	def test_it_initializes_each_column
		file = "./data/fixtures/items_fixtures.csv"
		items_data = CSV.open(file, headers: true, header_converters: :symbol)
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



end
