require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer_repository.rb'

class CustomerRepositoryTest < Minitest::Test

  def setup
    file = "./data/fixtures/customers_fixtures.csv"
		customer_data = CSV.open(file, headers: true, header_converters: :symbol)
		customer_repo = CustomerRepository.new(customer_data, nil)
  end

  def test_it_a_customer_object_is_created
    file = "./data/fixtures/single_id_customer.csv"
		customer_data = CSV.open(file, headers: true, header_converters: :symbol)
		customer_repo = CustomerRepository.new(customer_data, nil)

    result = customer_repo.customers["1"].class

    assert_equal Customer, result
  end

  def test_it_returns_all_instances_of_customers
    assert_equal 10, setup.all.length
    assert_equal Customer, setup.all[0].class
  end

  def test_it_returns_a_random_instance
    result1 = setup.random
    result2 = setup.random
    result3 = setup.random.class
    until result1 != result2
      result1 = setup.random
    end

    refute_equal result1, result2
    assert_equal Customer, result3
  end

  def test_it_finds_customer_by_id
    result = setup.find_by_id("3")

    assert_equal Customer, result.class
    assert_equal "3", result.id
  end
end
