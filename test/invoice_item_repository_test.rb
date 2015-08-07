require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repository.rb'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_a_invoice_item_object_is_created
    csv = "./data/fixtures/invoices_items_fixtures.csv"
		invoice_item_dat = CSV.open(csv, headers: true, header_converters: :symbol)
		invoice_item_repo = InvoiceItemRepository.new(invoice_item_dat, nil)

    result = invoice_item_repo.repository["1"].class

    assert_equal InvoiceItem, result
  end
end
