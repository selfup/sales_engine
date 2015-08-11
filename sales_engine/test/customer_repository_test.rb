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

    result = customer_repo.repository[1].class

    assert_equal Customer, result
  end

  def test_it_returns_all_instances_of_customers
    assert_equal 11, setup.all.length
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
    result = setup.find_by_id(3)

    assert_equal Customer, result.class
    assert_equal 3, result.id
  end

  def test_it_finds_a_customer_with_a_capital_first_name
    result = setup.find_by_first_name("Mariah")

    assert_equal Customer, result.class
    assert_equal "Mariah", result.first_name
  end

  def test_it_finds_a_customer_with_a_capital_name
    result = setup.find_by_first_name("Leanne")

    assert_equal Customer, result.class
    assert_equal "leanne", result.first_name
  end

  def test_it_finds_a_customer_with_two_first_names
    result = setup.find_by_first_name("Sylvester Stallone")

    assert_equal Customer, result.class
    assert_equal "Sylvester Stallone", result.first_name
  end

  def test_it_does_not_return_a_customer_with_two_first_names
    result = setup.find_by_first_name("Sylvester")

    assert_equal NilClass, result.class
  end

  def test_it_returns_nil_for_a_customer_that_does_not_exist
    result = setup.find_by_first_name("hank")

    assert_equal NilClass, result.class
  end

  def test_it_finds_a_customer_with_a_lowercase_last_name
    result = setup.find_by_last_name("considine")

    assert_equal Customer, result.class
    assert_equal "Considine", result.last_name
  end

  def test_it_finds_a_customer_with_a_capital_last_name
    result = setup.find_by_last_name("Considine")

    assert_equal Customer, result.class
    assert_equal "Considine", result.last_name
  end

  def test_it_finds_a_customer_with_two_last_names
    result = setup.find_by_last_name("Rusty Kuhn")

    assert_equal Customer, result.class
    assert_equal "Rusty Kuhn", result.last_name
  end

  def test_it_does_not_return_a_customer_with_two_last_names
    result = setup.find_by_last_name("Rusty")

    assert_equal NilClass, result.class
  end

  def test_it_returns_nil_for_a_customer_last_name_that_does_not_exist
    result = setup.find_by_last_name("hank")

    assert_equal NilClass, result.class
  end

  def test_it_returns_all_customers_with_matching_first_names
    result = setup.find_all_by_first_name("Mariah")

    assert_equal 2, result.length
    assert_equal "Mariah", result[0].first_name
    assert_equal "Mariah", result[1].first_name
  end

  def test_it_returns_all_customers_with_lowercase_first_names
    result = setup.find_all_by_first_name("Leanne")

    assert_equal 1, result.length
    assert_equal "leanne", result[0].first_name
  end

  def test_it_returns_an_empty_array_when_first_name_does_not_exist
    result = setup.find_all_by_first_name("Sylvester")

    assert_equal [], result
  end

  def test_it_returns_all_customers_with_matching_last_names
    result = setup.find_all_by_last_name("Toy")

    assert_equal 2, result.length
    assert_equal "Toy", result[0].last_name
    assert_equal "Toy", result[1].last_name
  end

  def test_it_returns_all_customers_with_lowercase_last_names
    result = setup.find_all_by_last_name("Braun")

    assert_equal 1, result.length
    assert_equal "braun", result[0].last_name
  end

  def test_it_returns_an_empty_array_when_last_name_does_not_exist
    result = setup.find_all_by_last_name("Rusty")

    assert_equal [], result
  end

end
