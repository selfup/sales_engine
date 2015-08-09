require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item.rb'
require './lib/sales_engine'

class ItemTest < Minitest::Test

	def test_it_initializes_each_column
		file = "./data/fixtures/single_id_item.csv"
		item_data = CSV.open(file, headers: true, header_converters: :symbol)
		items = item_data.map { |row| Item.new(row, nil) }

		id_result 				 = items[0].id
		name_result        = items[0].name
		description_result  = items[0].description
		unit_price_result  = items[0].unit_price
		merchant_id_result = items[0].merchant_id
		created_at_result  = items[0].created_at
		updated_at_result  = items[0].updated_at
		description = "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro."

		assert_equal "1", id_result
		assert_equal "Item Qui Esse", name_result
		assert_equal description, description_result
		assert_equal "75107", unit_price_result
		assert_equal "1", merchant_id_result
		assert_equal "2012-03-27 14:53:59 UTC", created_at_result
		assert_equal "2012-03-27 14:53:59 UTC", updated_at_result
	end

		def test_it_returns_a_collection_invoice_item_instance_associated_with_items
			engine = SalesEngine.new(true)
			engine.startup

			result = engine.item_repository.repository["99"].invoice_items

			assert_equal 2, result.length
			assert_equal "9", result[0].id
			assert_equal "10", result[1].id
		end

		def test_it_returns_an_item_instance_associated_with_invoice_items
			engine = SalesEngine.new(true)
			engine.startup

			result = engine.item_repository.repository["1"].merchant

			assert_equal "1", result.id
			assert_equal Merchant, result.class
		end

end
