require 'csv'
require_relative 'customer_repository'
require_relative 'customer_loader'
require_relative 'invoice_repository'
require_relative 'invoice_loader'


class SalesEngine
  attr_reader :customer_repository, :customer_data,
              :invoice_repository,  :invoice_data,
              :merchant_repository, :merchant_data

  def initialize
    @customer_data ||= CustomerLoader.new.load_all
    @invoice_data  ||= InvoiceLoader.new.load_all
    @merchant_data ||= MerchantLoader.new.load_all
  end

  def startup
    @customer_repository ||= CustomerRepository.new(@customer_data, self)
    @invoice_repository  ||= InvoiceRepository.new(@invoice_data, self)
    @merchant_repository ||= MerchantRepository.new(@merchant_data, self)
  end

end
