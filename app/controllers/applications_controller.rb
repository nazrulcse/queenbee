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
    # let's define orders time period
    start_date = params[:start_date] || 7.days.ago
    end_date   = params[:end_date] || Time.zone.now

    # Initialize service
    service = OrderWidgets.new(@application, start_date, end_date)

    # Call widgets
    # @min_order = @application.orders.minimum(:total_price)
  	@min_order    = service.order_min_price
    @max_order    = service.order_max_price
  	@median_order = service.order_median_price

    if @application.subscription_based?
      # render SaaS-specific stats.
    end

    # Recent orders
    @orders = @application.orders.order('date DESC').limit(20)
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
