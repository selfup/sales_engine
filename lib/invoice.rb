class Invoice
  attr_reader :id, :name, :description, :unit_price, :invoice_id,
              :created_at, :updated_at, :sales_engine

	def initialize(params, sales_engine)
    @id            = params[:id]
    @name          = params[:name]
    @description   = params[:description]
    @unit_price    = params[:unit_price]
    @invoice_id   = params[:invoice_id]
    @created_at    = params[:created_at]
    @updated_at    = params[:updated_at]
    @sales_engine  = sales_engine
  end

end
