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
    @orders_by_day = Order.group_by_day(:date, range: 30.days.ago.midnight..Time.now).count
  end

  def show
  	@order = Order.find(params[:id])
  end

  def import
  end

  def process_import
    if params[:file].present?
      app = Application.find(params[:application_id])
      app.orders.import(params[:file])
      redirect_to import_orders_url, notice: 'Orders were successfully imported.'
    else
      redirect_to import_orders_url, alert: 'Please select a file to import.'
    end
  end

end
