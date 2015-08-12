require 'bigdecimal'
require 'date'
require 'pry'

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

  def best_day
    all_successful_i_it = invoice_items.select{|i_item| i_item.invoice.success?}
    best_date = all_successful_i_it.reduce(Hash.new(0)) do |total, inv_item|
      total[inv_item.invoice.created_at] += inv_item.quantity
      total
    end
    best_date.key(best_date.values.max)
  end

end
