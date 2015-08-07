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

    result = invoice_item_repo.repository["1"].class

    assert_equal InvoiceItem, result
  end

  def test_it_returns_all_instances_of_invoices
    assert_equal 10, setup.all.length
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

end
