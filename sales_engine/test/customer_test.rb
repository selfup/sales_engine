require_relative 'test_helper'
require 'csv'
require 'date'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer.rb'
require './lib/sales_engine'

class CustomerTest < Minitest::Test

	def setup
		file = "./data/fixtures/single_id_customer.csv"
		customer_data = CSV.open(file, headers: true, header_converters: :symbol)
		customers = customer_data.map { |row| Customer.new(row, nil) }
	end

	def test_it_initializes_each_column
		id_result 				= setup[0].id
		first_name_result = setup[0].first_name
		last_name_result  = setup[0].last_name
		created_at_result = setup[0].created_at
		updated_at_result = setup[0].updated_at

		assert_equal 1, id_result
		assert_equal "Joey", first_name_result
		assert_equal "Ondricka", last_name_result
		assert_equal Date.parse("2012-03-27 14:54:09 UTC"), created_at_result
		assert_equal Date.parse("2012-03-27 14:54:09 UTC"), updated_at_result
	end

	def test_it_returns_an_invoice_instance_associated_with_customers
		engine = SalesEngine.new("test", true)
		engine.startup

		result = engine.customer_repository.repository[2].invoices

		assert_equal 9, result[0].id
		assert_equal Invoice, result[0].class
	end

	def test_it_returns_an_array_of_transaction_instances_associated_with_customer
		engine = SalesEngine.new("test", true)
		engine.startup

		result = engine.customer_repository.repository[1].transactions

		assert_equal 8, result.length
		assert_equal Transaction, result.first.class
		assert_equal 6, result[5].id
	end

	def test_merchant_with_most_successful_transactions_is_returned
		engine = SalesEngine.new("test", true)
		engine.startup

		result = engine.customer_repository.repository[1].favorite_merchant

		assert_equal Merchant, result.class
		assert_equal 1, result.id
	end

end
