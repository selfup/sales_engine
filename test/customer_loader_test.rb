# require 'csv'
# require 'minitest/autorun'
# require 'minitest/pride'
# require './lib/customer_loader.rb'
#
# class CustomerLoaderTest < Minitest::Test
#
#   def test_it_can_read_a_csv_file
#     file = './data/fixtures/customers_fixtures.csv'
#     result = CustomerLoader.new.load_all(file)
#
#     assert_equal 10, result.size
#   end
# end
