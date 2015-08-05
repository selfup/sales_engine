require 'minitest/autorun'
require 'minitest/pride'
require '../lib/invoice.rb'

class InvoiceTest < Minitest::Test

  def test_it_initializes_an_id
    sample = Invoice.new()
  end

end
