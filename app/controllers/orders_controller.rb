class OrdersController < BaseController

  def index
  	if params[:query].present?
  		@orders = PgSearch.multisearch(params[:query])
  		#Order.search_by_keyword(params[:q]).order('created_at DESC').limit(20)
    else
    	@orders = Order.order('created_at DESC').limit(20)
  	end
  end

  def show
  	@order = Order.find(params[:id])
  end

end
