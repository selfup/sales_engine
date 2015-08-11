require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository.rb'

class MerchantRepositoryTest < Minitest::Test

  def setup
    file = "./data/fixtures/merchants_fixtures.csv"
		merchant_data = CSV.open(file, headers: true, header_converters: :symbol)
		merchant_repo = MerchantRepository.new(merchant_data, nil)
  end

  def test_it_a_merchant_object_is_created
    file = "./data/fixtures/single_id_merchant.csv"
		merchant_data = CSV.open(file, headers: true, header_converters: :symbol)
		merchant_repo = MerchantRepository.new(merchant_data, nil)

    result = merchant_repo.repository[1].class

    assert_equal Merchant, result
  end

  def test_it_returns_all_instances_of_merchants
    assert_equal 10, setup.all.length
    assert_equal Merchant, setup.all[0].class
  end

  def test_it_returns_a_random_instance
    result1 = setup.random
    result2 = setup.random
    result3 = setup.random.class
    until result1 != result2
      result1 = setup.random
    end

    refute_equal result1, result2
    assert_equal Merchant, result3
  end

  def test_it_finds_merchant_by_id
    result = setup.find_by_id(3)

    assert_equal Merchant, result.class
    assert_equal 3, result.id
  end

  def test_it_finds_a_merchant_with_a_capital_first_name
    result = setup.find_by_name("Williamson Group")

    assert_equal Merchant, result.class
    assert_equal "Williamson Group", result.name
  end

  def test_it_finds_a_merchant_with_a_capital_name
    result = setup.find_by_name("Cummings-Chiel")

    assert_equal Merchant, result.class
    assert_equal "cummings-chiel", result.name
  end

  def test_it_finds_a_merchant_with_two_first_names
    result = setup.find_by_name("Williamson Group")

    assert_equal Merchant, result.class
    assert_equal "Williamson Group", result.name
  end

  def test_it_does_not_return_a_merchant_with_two_first_names
    result = setup.find_by_name("Williamson")

    assert_equal NilClass, result.class
  end

  def test_it_returns_nil_for_a_merchant_that_does_not_exist
    result = setup.find_by_name("hank")

    assert_equal NilClass, result.class
  end

  def test_it_returns_all_merchants_with_matching_names
    result = setup.find_all_by_name("Williamson Group")

    assert_equal 2, result.length
    assert_equal "Williamson Group", result[0].name
    assert_equal "Williamson Group", result[1].name
  end

  def test_it_returns_all_merchants_with_lowercase_names
    result = setup.find_all_by_name("cummings-chiel")

    assert_equal 1, result.length
    assert_equal "cummings-chiel", result[0].name
  end

  def test_it_returns_an_empty_array_when_merchant_name_does_not_exist
    result = setup.find_all_by_name("Sylvester")

    assert_equal [], result
  end

end
