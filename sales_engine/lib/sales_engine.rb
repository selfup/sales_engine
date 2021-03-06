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
  attr_reader :merchant_repository, :merchant_data,
              :item_repository, :item_data,
              :invoice_repository, :invoice_data,
              :invoice_item_repository, :inv_item_data,
              :item_repository, :item_data,
              :transaction_repository, :trans_data,
              :customer_repository, :customer_data

  def initialize(file, fix = false)
    trans  = './csvs/transactions.csv'
    inv_it = './csvs/invoice_items.csv'
    @customer_data ||= CustomerLoader.new.load_all('./csvs/customers.csv', fix)
    @invoice_data  ||= InvoiceLoader.new.load_all('./csvs/invoices.csv', fix)
    @merchant_data ||= MerchantLoader.new.load_all('./csvs/merchants.csv', fix)
    @item_data     ||= ItemLoader.new.load_all('./csvs/items.csv', fix)
    @inv_item_data ||= InvoiceItemLoader.new.load_all(inv_it, fix)
    @trans_data    ||= TransactionLoader.new.load_all(trans, fix)
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

if __FILE__ == $0
  engine = SalesEngine.new(true)
  engine.startup
end
