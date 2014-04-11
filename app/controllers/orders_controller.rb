class OrdersController < BaseController

  def index
  	if params[:query].present?
  		@orders = Order.search_by_keyword(params[:query]).limit(30)
    else
    	@orders = Order.order('created_at DESC').limit(20)
  	end
  end

  def show
  	@order = Order.find(params[:id])
  end

end
