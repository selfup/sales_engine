require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction_repository.rb'

class TransactionRepositoryTest < Minitest::Test

  def test_it_a_transaction_object_is_created
    file = "./data/fixtures/single_id_transaction.csv"
		transaction_data = CSV.open(file, headers: true, header_converters: :symbol)
		transaction_repo = TransactionRepository.new(transaction_data, nil)

    result = transaction_repo.transactions["1"].class

    assert_equal Transaction, result
  end
end
