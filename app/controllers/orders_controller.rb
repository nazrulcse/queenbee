class OrdersController < BaseController

  def index
    @applications = Application.active.order('name')
  	if params[:query].present?
  		@orders = Order.search_by_keyword(params[:query]).limit(20)
    else
      orders = Order.within_period(Date.today.beginning_of_year, Date.today)
      @orders = orders.order('created_at DESC').limit(20)
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
      app.orders.import_file(params[:file])
      redirect_to import_orders_url, notice: 'Orders were successfully imported.'
    else
      redirect_to import_orders_url, alert: 'Please select a file to import.'
    end
  end

end
