require 'csv'
require_relative 'customer_repository'
require_relative 'customer_loader'
require_relative 'invoice_repository'
require_relative 'invoice_loader'
require_relative 'merchant_repository'
require_relative 'merchant_loader'
require_relative 'item_repository'
require_relative 'item_loader'
require_relative 'invoice_item_repository'
require_relative 'invoice_item_loader'
require_relative 'transaction_repository'
require_relative 'transaction_loader'

class SalesEngine
  attr_reader :customer_repository, :customer_data,
              :invoice_repository,  :invoice_data,
              :merchant_repository, :merchant_data,
              :item_repository, :item_data,
              :invoice_item_repository, :inv_item_data,
              :transaction_repository, :trans_data

  def initialize
    @customer_data ||= CustomerLoader.new.load_all
    @invoice_data  ||= InvoiceLoader.new.load_all
    @merchant_data ||= MerchantLoader.new.load_all
    @item_data     ||= ItemLoader.new.load_all
    @inv_item_data ||= InvoiceItemLoader.new.load_all
    @trans_data    ||= TransactionLoader.new.load_all
  end

  def startup
    @customer_repository     ||= CustomerRepository.new(@customer_data, self)
    @invoice_repository      ||= InvoiceRepository.new(@invoice_data, self)
    @merchant_repository     ||= MerchantRepository.new(@merchant_data, self)
    @item_repository         ||= ItemRepository.new(@item_data, self)
    @invoice_item_repository ||= InvoiceItemRepository.new(@inv_item_data, self)
    @transaction_repository  ||= TransactionRepository.new(@trans_data, self)
  end

end
