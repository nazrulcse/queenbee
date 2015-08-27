class CoreMetrics
  # Philosophy:
  # generating stats is resource-intensive
  # therefore need to optimize queries and responses.
  # stats are consumed by the app but also by the API
  # to avoid discrepancy it's best to use one single source
  # to fetch data.
  #
  # however the rails-way is to expire cache
  # need to leverage order_widgets as well

  # CoreMetrics.new(Application.first).process
  def initialize(application)
    @application = application
    @orders      = application.orders
  end

  def process
    service = Metrics::Base.new(@orders)
    @application.metrics["orders_count"]   = service.orders_count
    @application.metrics["orders_revenue"] = service.orders_revenue
    @application.metrics["orders_min_price"] = service.orders_min_price
    @application.metrics["orders_max_price"] = service.orders_min_price
    @application.metrics["orders_average_price"] = service.orders_avg_price
    # @application.metrics["orders_revenue"] = total_revenue
    @application.save!
  end

  def total_revenue

  end

end
