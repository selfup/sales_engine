require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository.rb'

class ItemRepositoryTest < Minitest::Test

  def test_it_an_item_object_is_created
    file = "./data/fixtures/items_fixtures.csv"
		item_data = CSV.open(file, headers: true, header_converters: :symbol)
		item_repo = ItemRepository.new(item_data, nil)

    result = item_repo.repository["1"].class

    assert_equal Item, result
  end
end
