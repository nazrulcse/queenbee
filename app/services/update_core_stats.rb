class UpdateCoreStats
  # Philosophy:
  # generating stats is resource-intensive
  # therefore need to optimize queries and responses.
  # stats are consumed by the app but also by the API
  # to avoid discrepancy it's best to use one single source
  # to fetch data.
  #
  # however the rails-way is to expire cache
  # need to leverage order_widgets as well

  def initialize(application)
    @application = application
    @orders      = application.orders
  end

  def process
    @application.metrics["orders_count"] = count_of_orders
    @application.save!
  end

  def count_of_orders
    # group orders
    today, this_week, last_week, this_month, last_month, total =
      split_by_time_period(@orders)

    # build hash
    {
      today: today.length,
      this_week: 25,
      last_week: 30,
      this_month:
      last_month: 50,
      total: 75
    }
  end

  def total_revenue

  end

  private

    def split_by_time_period(serie)
      today = serie.group_by_day(Date.today)

      return today
    end


end
