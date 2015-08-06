require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_repository.rb'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    file = "./data/fixtures/invoices_fixtures.csv"
  	invoice_data = CSV.open(file, headers: true, header_converters: :symbol)
		invoice_repo = InvoiceRepository.new(invoice_data, nil)
  end

  def test_it_a_invoice_object_is_created
    file = "./data/fixtures/single_id_invoice.csv"
		invoice_data = CSV.open(file, headers: true, header_converters: :symbol)
		invoice_repo = InvoiceRepository.new(invoice_data, nil)

    result = invoice_repo.repository["1"].class

    assert_equal Invoice, result
  end

  def test_it_returns_all_instances_of_invoices
    assert_equal 11, setup.all.length
    assert_equal Invoice, setup.all[0].class
  end

  def test_it_returns_a_random_instance
    result1 = setup.random
    result2 = setup.random
    result3 = setup.random.class
    until result1 != result2
      result1 = setup.random
    end

    refute_equal result1, result2
    assert_equal Invoice, result3
  end

  def test_it_finds_invoice_by_id
    result = setup.find_by_id("3")

    assert_equal Invoice, result.class
    assert_equal "3", result.id
  end

  def test_it_finds_an_invoice_customer_id
    result = setup.find_by_customer_id("1")

    assert_equal Invoice, result.class
    assert_equal "1", result.customer_id
  end
  #
  # def test_it_finds_a_invoice_with_a_capital_name
  #   result = setup.find_by_invoice_name("Cummings-Chiel")
  #
  #   assert_equal Invoice, result.class
  #   assert_equal "cummings-chiel", result.name
  # end
  #
  # def test_it_finds_a_invoice_with_two_first_names
  #   result = setup.find_by_invoice_name("Williamson Group")
  #
  #   assert_equal Invoice, result.class
  #   assert_equal "Williamson Group", result.name
  # end
  #
  # def test_it_does_not_return_a_invoice_with_two_first_names
  #   result = setup.find_by_invoice_name("Williamson")
  #
  #   assert_equal NilClass, result.class
  # end
  #
  # def test_it_returns_nil_for_a_invoice_that_does_not_exist
  #   result = setup.find_by_invoice_name("hank")
  #
  #   assert_equal NilClass, result.class
  # end
  #
  # def test_it_returns_all_invoices_with_matching_names
  #   result = setup.find_all_by_invoice_name("Williamson Group")
  #
  #   assert_equal 2, result.length
  #   assert_equal "Williamson Group", result[0].name
  #   assert_equal "Williamson Group", result[1].name
  # end
  #
  # def test_it_returns_all_invoices_with_lowercase_names
  #   result = setup.find_all_by_invoice_name("cummings-chiel")
  #
  #   assert_equal 1, result.length
  #   assert_equal "cummings-chiel", result[0].name
  # end
  #
  # def test_it_returns_an_empty_array_when_invoice_name_does_not_exist
  #   result = setup.find_all_by_invoice_name("Sylvester")
  #
  #   assert_equal [], result
  # end

end
