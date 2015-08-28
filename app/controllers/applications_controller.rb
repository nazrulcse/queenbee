class ApplicationsController < BaseController
	before_action :set_application, only: [:show, :edit, :update, :destroy]
	before_action :set_locale,      only: :show

  def index
  	@applications = Application.order('name').limit(20)
  end

  def new
  	@application = Application.new
  end

  def edit
  end

  def show
    # let's define time period for orders
    start_date = params[:start_date] || 7.days.ago
    end_date   = params[:end_date] || Time.zone.now

    # Initialize service
    service = OrderWidgets.new(@application, start_date, end_date)
    @orders = service.orders

    # Widgets
    ## Simple stats
    @orders_size   = @orders.length
    @orders_avg    = service.orders_average
    @total_revenue = service.total_revenue
    @daily_average = service.daily_revenue_average
  	@min_order     = service.min_price
    @max_order     = service.max_price
  	@avg_order     = service.average_price
    @products_avg  = service.products_average
    @referral      = service.referral

    ## Graphs
    @revenue           = service.revenue
    @monthly_revenue   = service.monthly_revenue
    @orders_count      = service.orders_count
    @average_price     = service.orders_average_price
    @most_used_coupons = service.most_used_coupons
    @revenue_by_coupon = service.revenue_by_coupon
    @sources           = service.sources
    @products_count    = service.products_count
    @top_clients       = service.top_clients
    @top_countries     = service.top_countries
    @top_cities        = service.top_cities
    @referrals         = service.referral

    if @application.subscription_based?
      # render SaaS-specific stats.
    end

    # Recent orders
    @orders = @application.orders.order('date DESC').limit(20)

    respond_to do |format|
      format.html
      format.json { render json: @application, location: api_application_url(@application) }
    end
  end

  def create
    @application = Application.new(safe_params)

    respond_to do |format|
      if @application.save
        format.html { redirect_to applications_url, notice: 'Application was successfully created.' }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @application.update(safe_params)
        format.html { redirect_to applications_url, notice: 'Application was successfully updated.' }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @application.destroy
    respond_to do |format|
      format.html { redirect_to applications_url, notice: 'Application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_locale
    I18n.locale = @application.locale || I18n.default_locale
  end

  def set_application
  	@application = Application.includes(:orders).find(params[:id])
  end

  def safe_params
  	params.require(:application).permit(:name, :locale, :subscription_based)
  end

end
