class OrdersController < BaseController

  def index
  	if params[:query].present?
  		@orders = Order.search_by_keyword(params[:query]).limit(30)
    else
    	@orders = Order.order('created_at DESC').limit(20)
  	end
    @orders_by_day = Order.within_period(30.days.ago, Time.now).count(group: "DATE(date)")
  end

  def show
  	@order = Order.find(params[:id])
  end

end
