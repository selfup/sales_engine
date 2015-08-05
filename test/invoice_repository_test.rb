require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_repository.rb'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_a_invoice_object_is_created
    file = "./data/fixtures/single_id_invoice.csv"
		invoice_data = CSV.open(file, headers: true, header_converters: :symbol)
		invoice_repo = InvoiceRepository.new(invoice_data, nil)

    result = invoice_repo.invoices["1"].class

    assert_equal Invoice, result
  end
end
