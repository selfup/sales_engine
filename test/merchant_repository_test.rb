require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository.rb'

class MerchantRepositoryTest < Minitest::Test

  def test_it_a_merchant_object_is_created
    file = "./data/fixtures/single_id_merchant.csv"
		merchant_data = CSV.open(file, headers: true, header_converters: :symbol)
		merchant_repo = MerchantRepository.new(merchant_data, nil)

    result = merchant_repo.merchants["1"].class

    assert_equal Merchant, result
  end
end
