require_relative 'test_helper'
require 'csv'
require './lib/transaction_repository.rb'

class TransactionRepositoryTest < Minitest::Test

  def setup
    file = "./data/fixtures/transactions_items_fixtures.csv"
    trans_data = CSV.open(file, headers: true, header_converters: :symbol)
    trans_repo = TransactionRepository.new(trans_data, nil)
  end

  def test_it_a_transaction_object_is_created
    file = "./data/fixtures/single_id_transactions.csv"
		trans_data = CSV.open(file, headers: true, header_converters: :symbol)
		trans_repo = TransactionRepository.new(trans_data, nil)

    result = trans_repo.repository[1].class

    assert_equal Transaction, result
  end

  def test_it_returns_all_instances_of_transactions
    assert_equal 11, setup.all.length
    assert_equal Transaction, setup.all[0].class
  end

  def test_it_returns_a_random_instance
    result1 = setup.random
    result2 = setup.random
    result3 = setup.random.class
    until result1 != result2
      result1 = setup.random
    end

    refute_equal result1, result2
    assert_equal Transaction, result3
  end

  def test_it_finds_transaction_by_id
    result = setup.find_by_id(3)

    assert_equal Transaction, result.class
    assert_equal 3, result.id
  end

  def test_it_finds_a_transaction_given_invoice_id
    result = setup.find_by_invoice_id(10)

    assert_equal 9, result.id
  end

  def test_it_finds_all_transactions_given_invoice_id
    result = setup.find_all_by_invoice_id(10)

    assert_equal 2, result.length
    assert_equal 10, result[0].invoice_id
    assert_equal 10, result[1].invoice_id
  end

  def test_it_finds_a_transaction_given_a_card_number
    result = setup.find_by_credit_card_number("4354495077693036")

    assert_equal 3, result.id
  end

  def test_it_finds_all_transactions_given_a_card_number
    result = setup.find_all_by_credit_card_number("4354495077693036")

    assert_equal 2, result.length
    assert_equal "4354495077693036", result[0].credit_card_number
    assert_equal "4354495077693036", result[1].credit_card_number
  end

  def test_it_finds_a_transaction_result
    result = setup.find_by_result("failed")

    assert_equal 3, result.id
  end

  def test_it_finds_all_successful_transactions
    result = setup.find_all_by_result("success")

    assert_equal 8, result.length
  end

  def test_it_finds_all_failed_transactions
    result = setup.find_all_by_result("failed")

    assert_equal 3, result.length
  end

end
