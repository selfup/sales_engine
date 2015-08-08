class Item
  attr_reader :id, :name, :description, :merchant_id,
              :unit_price, :created_at, :updated_at

	def initialize(params, item_repository)
    @id              = params[:id]
    @name            = params[:name]
    @description     = params[:description]
    @merchant_id     = params[:merchant_id]
    @unit_price      = params[:unit_price]
    @created_at      = params[:created_at]
    @updated_at      = params[:updated_at]
    @item_repository = item_repository
  end

end
