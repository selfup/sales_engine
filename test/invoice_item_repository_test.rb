require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repository.rb'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_a_invoice_item_object_is_created
    file = "./data/fixtures/single_id_invoice_item.csv"
		invoice_item_data = CSV.open(file, headers: true, header_converters: :symbol)
		invoice_item_repo = InvoiceItemRepository.new(invoice_item_data, nil)

    result = invoice_item_repo.invoice_items["1"].class

    assert_equal InvoiceItem, result
  end
end
