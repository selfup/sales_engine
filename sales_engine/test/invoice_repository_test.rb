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

  def test_an_invoice_object_is_created
    file = "./data/fixtures/single_id_invoice.csv"
		invoice_data = CSV.open(file, headers: true, header_converters: :symbol)
		invoice_repo = InvoiceRepository.new(invoice_data, nil)

    result = invoice_repo.repository[1].class

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
    result = setup.find_by_id(3)

    assert_equal Invoice, result.class
    assert_equal 3, result.id
  end

  def test_it_finds_an_invoice_customer_id
    result = setup.find_by_customer_id(1)

    assert_equal Invoice, result.class
    assert_equal 1, result.customer_id
  end

  def test_it_finds_an_invoice_merchant_id
    result = setup.find_by_merchant_id(78)

    assert_equal Invoice, result.class
    assert_equal 78, result.merchant_id
  end

  def test_it_finds_an_invoice_status
    result = setup.find_by_status("shipped")

    assert_equal Invoice, result.class
    assert_equal "shipped", result.status
  end

  def test_it_returns_nil_for_a_invoice_that_does_not_exist
    result = setup.find_by_id("hank")

    assert_equal Fixnum, result.class
  end

  def test_it_returns_all_customer_ids
    result = setup.find_all_by_customer_id(1)

    assert_equal 9, result.length
    assert_equal 1, result[0].customer_id
    assert_equal 1, result[1].customer_id
    assert_equal 1, result[2].customer_id
    assert_equal 1, result[3].customer_id
    assert_equal 1, result[4].customer_id
    assert_equal 1, result[5].customer_id
    assert_equal 1, result[6].customer_id
    assert_equal 1, result[7].customer_id
    assert_equal 1, result[8].customer_id
  end

  def test_it_returns_an_empty_array_when_an_invoice_customer_id_does_not_exist
    result = setup.find_all_by_customer_id("Sylvester")

    assert_equal [], result
  end

  def test_it_returns_all_merchant_ids
    result = setup.find_all_by_merchant_id(1)

    assert_equal 2, result.length
    assert_equal 1, result[0].merchant_id
    assert_equal 1, result[1].merchant_id
  end

  def test_it_returns_an_empty_array_when_an_invoice_merchant_id_does_not_exist
    result = setup.find_all_by_merchant_id("Sylvester")

    assert_equal [], result
  end

  def test_it_returns_all_statuses
    result = setup.find_all_by_status("shipped")

    assert_equal 11, result.length
    assert_equal "shipped", result[0].status
    assert_equal "shipped", result[1].status
    assert_equal "shipped", result[2].status
    assert_equal "shipped", result[3].status
    assert_equal "shipped", result[4].status
    assert_equal "shipped", result[5].status
    assert_equal "shipped", result[6].status
    assert_equal "shipped", result[7].status
    assert_equal "shipped", result[8].status
    assert_equal "shipped", result[9].status
    assert_equal "shipped", result[10].status
  end

  def test_it_returns_an_empty_array_when_an_invoice_status_does_not_exist
    result = setup.find_all_by_status("Sylvester")

    assert_equal [], result
  end

end
