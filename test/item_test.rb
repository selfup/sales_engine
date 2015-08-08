require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item.rb'

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

end
