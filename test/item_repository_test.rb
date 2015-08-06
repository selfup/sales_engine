require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository.rb'

class ItemRepositoryTest < Minitest::Test

  def setup
    file = "./data/fixtures/items_fixtures.csv"
    item_data = CSV.open(file, headers: true, header_converters: :symbol)
    item_repo = ItemRepository.new(item_data, nil)
  end

  def test_it_an_item_object_is_created
    file = "./data/fixtures/items_fixtures.csv"
		item_data = CSV.open(file, headers: true, header_converters: :symbol)
		item_repo = ItemRepository.new(item_data, nil)

    result = item_repo.repository["1"].class

    assert_equal Item, result
  end

  def test_it_returns_all_instances_of_items
    assert_equal 11, setup.all.length
    assert_equal Item, setup.all[0].class
  end

  def test_it_returns_a_random_instance
    result1 = setup.random
    result2 = setup.random
    result3 = setup.random.class
    until result1 != result2
      result1 = setup.random
    end

    refute_equal result1, result2
    assert_equal Item, result3
  end

  def test_it_finds_item_by_name
    result = setup.find_by_items_name("Item Nemo Facere")

    assert_equal Item, result.class
    assert_equal "Item Nemo Facere", result.name
  end

  def test_it_finds_an_item_merchant_id
    result = setup.find_by_merchant_id("1")

    assert_equal Item, result.class
    assert_equal "1", result.merchant_id
  end

end
