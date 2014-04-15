class OrdersController < BaseController

  def index
  	if params[:query].present?
  		@orders = Order.search_by_keyword(params[:query]).limit(30)
    else
    	@orders = Order.order('created_at DESC').limit(20)

      # stats
      # fetch orders
      orders = Order.within_period(Date.today, 7.days.ago)

      # Today's orders
    	daily_orders = orders.by_day(Date.today)
    	@daily_orders_count = daily_orders.length
    	@daily_orders_amount = daily_orders.map{|o| o.total_price}.sum

      # This week orders
    	weekly_orders = orders
    	@weekly_orders_count = weekly_orders.length
    	@weekly_orders_amount = weekly_orders.map{|o| o.total_price}.sum

      # This month orders
    	monthly_orders = Order.by_month(Date.today)
    	@monthly_orders_count = monthly_orders.length
    	@monthly_orders_amount = monthly_orders.map{|o| o.total_price}.sum
  	end
  end

  def show
  	@order = Order.find(params[:id])
  end

end
