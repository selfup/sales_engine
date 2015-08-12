require 'bigdecimal'
require 'date'

class Item
  attr_reader :id, :name, :description, :merchant_id,
              :unit_price, :created_at, :updated_at

  def initialize(params, item_repository)
    @id              ||= params[:id].to_i
    @name            ||= params[:name]
    @description     ||= params[:description]
    @merchant_id     ||= params[:merchant_id].to_i
    @unit_price      ||= BigDecimal.new(params[:unit_price])
    @created_at      ||= Date.parse(params[:created_at])
    @updated_at      ||= Date.parse(params[:updated_at])
    @item_repository ||= item_repository
  end

  def invoice_items
    inv_item_repo = @item_repository.sales_engine.invoice_item_repository
    inv_item_repo.find_all_by_item_id(@id)
  end

  def merchant
    merchant_repo = @item_repository.sales_engine.merchant_repository
    merchant_repo.find_by_id(@merchant_id)
  end

  #Pull invoice_item_repo
  #Iterate through Invoice_Items and determine if Invoice is success
    #If it is pull date(key) and quantity(value) into Hash
  #Determine the highest quantity and output Date

  def best_day
    best_date = Hash.new(0)
    i_i_repo = @item_repository.sales_engine.invoice_item_repository
    inv_items = i_i_repo.repository.select{|key, item| item.invoice.success?}
    inv_items.map do |key, inv_item|
      best_date[inv_item.invoice.updated_at] += inv_item.quantity * inv_item.unit_price
    end
    require 'pry'; binding.pry
    best_date.key(best_date.values.max)
  end

end
