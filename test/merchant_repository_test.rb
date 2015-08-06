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

    result = merchant_repo.repository["1"].class

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
    result = setup.find_by_id("3")

    assert_equal Merchant, result.class
    assert_equal "3", result.id
  end

end
