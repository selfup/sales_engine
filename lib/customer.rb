class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at

	def initialize(params)
    @id = params[:id]
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @created_at = params[:created_at]
    @updated_at = params[:updated_at]
  end

end
