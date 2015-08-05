require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer_repository.rb'

class CustomerRepositoryTest < Minitest::Test

  def test_it_a_customer_object_is_created
    file = "./data/fixtures/single_id_customer.csv"
		customer_data = CSV.open(file, headers: true, header_converters: :symbol)
		customer_repo = CustomerRepository.new(customer_data, nil)

    result = customer_repo.customers["1"].class

    assert_equal Customer, result
  end
end
