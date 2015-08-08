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

  def test_it_finds_all_item_by_name
    result = setup.find_all_by_item_name("Item Ea Voluptatum")

    assert_equal 2, result.length
  end

  def test_it_returns_an_empty_array_when_an_invoice_customer_id_does_not_exist
    result = setup.find_all_by_item_name("Sylvester")

    assert_equal [], result
  end

  def test_it_finds_an_item_merchant_id
    result = setup.find_by_merchant_id("1")

    assert_equal Item, result.class
    assert_equal "1", result.merchant_id
  end

  def test_it_returns_all_merchant_ids
    result = setup.find_all_by_merchant_id("1")

    assert_equal 11, result.length
    assert_equal "1", result[0].merchant_id
    assert_equal "1", result[1].merchant_id
    assert_equal "1", result[2].merchant_id
    assert_equal "1", result[3].merchant_id
    assert_equal "1", result[4].merchant_id
    assert_equal "1", result[5].merchant_id
    assert_equal "1", result[6].merchant_id
    assert_equal "1", result[7].merchant_id
    assert_equal "1", result[8].merchant_id
    assert_equal "1", result[9].merchant_id
    assert_equal "1", result[10].merchant_id
  end

  def test_it_returns_an_empty_array_when_an_item_merchant_id_does_not_exist
    result = setup.find_all_by_merchant_id("Sylvester")

    assert_equal [], result
  end

  def test_it_finds_an_item_description
    desc = "Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora."
    result = setup.find_by_description(desc)

    assert_equal Item, result.class
    assert_equal desc, result.description
  end

  def test_it_returns_all_statuses
    desc = "Sunt officia eum qui molestiae. Nesciunt quidem cupiditate reiciendis est commodi non. Atque eveniet sed. Illum excepturi praesentium reiciendis voluptatibus eveniet odit perspiciatis. Odio optio nisi rerum nihil ut."
    result = setup.find_all_by_description(desc)

    assert_equal 2, result.length
    assert_equal desc, result[0].description
    assert_equal desc, result[1].description
  end

  def test_it_returns_an_empty_array_when_a_description_does_not_exist
    result = setup.find_all_by_merchant_id("Sylvester")

    assert_equal [], result
  end

  def test_it_finds_an_item_unit_price
    result = setup.find_by_unit_price("32301")

    assert_equal Item, result.class
    assert_equal "32301", result.unit_price
  end

  def test_it_finds_an_item_unit_price
    result = setup.find_all_by_unit_price("32301")

    assert_equal 2, result.length
    assert_equal "32301", result[0].unit_price
    assert_equal "32301", result[1].unit_price
  end

  def test_it_returns_an_empty_array_when_a_description_does_not_exist
    result = setup.find_all_by_unit_price("Sylvester")

    assert_equal [], result
  end

end
