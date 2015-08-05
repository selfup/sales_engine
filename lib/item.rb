class Item
  attr_reader :id, :item_id, :invoice_id, :unit_price, :updated_at

	def initialize(params, item_repository)
    @id              = params[:id]
    @item_id         = params[:item_id]
    @invoice_id      = params[:invoice_id]
    @unit_price      = params[:unit_price]
    @created_at      = params[:created_at]
    @updated_at      = params[:updated_at]
    @item_repository = item_repository
  end

end
