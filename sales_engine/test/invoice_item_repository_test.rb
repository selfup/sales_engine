require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repository.rb'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    file = "./data/fixtures/invoices_items_fixtures.csv"
    invoice_item_dat = CSV.open(file, headers: true, header_converters: :symbol)
    invoice_item_repo = InvoiceItemRepository.new(invoice_item_dat, nil)
  end

  def test_an_invoice_item_object_is_created
    csv = "./data/fixtures/invoices_items_fixtures.csv"
		invoice_item_dat = CSV.open(csv, headers: true, header_converters: :symbol)
		invoice_item_repo = InvoiceItemRepository.new(invoice_item_dat, nil)

    result = invoice_item_repo.repository[1].class

    assert_equal InvoiceItem, result
  end

  def test_it_returns_all_instances_of_invoices
    assert_equal 11, setup.all.length
    assert_equal InvoiceItem, setup.all[0].class
  end

  def test_it_returns_a_random_instance
    result1 = setup.random
    result2 = setup.random
    result3 = setup.random.class
    until result1 != result2
      result1 = setup.random
    end

    refute_equal result1, result2
    assert_equal InvoiceItem, result3
  end

  def test_it_returns_an_invoice_item_given_an_invoice_item_id
    result = setup.find_by_id(3)

    assert_equal 3, result.id
  end

  def test_it_returns_an_invoice_item_instance_given_an_item_id
    result = setup.find_by_item_id(541)

    assert_equal 6, result.id
  end

  def test_it_returns_all_invoice_item_instances_given_an_item_id
    result = setup.find_all_by_item_id(541)

    assert_equal 2, result.length
    assert_equal 6, result[0].id
    assert_equal 7, result[1].id
  end

  def test_it_returns_an_empty_array_for_an_item_id_that_does_not_exist
    result = setup.find_all_by_item_id(2000)

    assert_equal [], result
  end

  def test_it_returns_an_invoice_item_instance_given_an_invoice_id
    result = setup.find_by_invoice_id(2)

    assert_equal 9, result.id
  end

  def test_it_returns_all_invoice_item_instances_given_an_invoice_id
    result = setup.find_all_by_invoice_id(2)

    assert_equal 2, result.length
    assert_equal 9, result[0].id
    assert_equal 10, result[1].id
  end

  def test_it_returns_an_empty_array_for_an_invoice_id_that_does_not_exist
    result = setup.find_all_by_invoice_id(2000)

    assert_equal [], result
  end

  def test_it_returns_an_invoice_item_instance_given_a_quantity
    result = setup.find_by_quantity(6)

    assert_equal 8, result.id
  end

  def test_it_returns_all_invoice_item_instances_given_a_quantity
    result = setup.find_all_by_quantity(6)

    assert_equal 2, result.length
    assert_equal 8, result[0].id
    assert_equal 9, result[1].id
  end

  def test_it_returns_an_empty_array_for_a_quantity_that_does_not_exist
    result = setup.find_all_by_invoice_id(2000)

    assert_equal [], result
  end

  def test_it_returns_an_invoice_item_instance_given_a_unit_price
    result = setup.find_by_unit_price(76941)

    assert_equal 8, result.id
  end

  def test_it_returns_all_invoice_item_instances_given_a_unit_price
    result = setup.find_all_by_unit_price(76941)

    assert_equal 2, result.length
    assert_equal 8, result[0].id
    assert_equal 9, result[1].id
  end

  def test_it_returns_an_empty_array_for_a_unit_price_that_does_not_exist
    result = setup.find_all_by_invoice_id(2000)

    assert_equal [], result
  end

end
