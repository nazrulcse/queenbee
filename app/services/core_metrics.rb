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
    @application.metrics["orders_count"]     = service.orders_count
    @application.metrics["net_revenue"]      = service.net_revenue
    @application.metrics["min_amount"]       = service.min_amount
    @application.metrics["max_amount"]       = service.max_amount
    @application.metrics["average_amount"]   = service.avg_amount
    @application.metrics["total_fees"]       = service.total_fees
    @application.metrics["active_customers"] = service.active_customers
    # @application.metrics["cancellations"]    = service.cancellations

    @application.save!
  end

end
