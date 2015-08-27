module Metrics

  # Metrics::Base.new(Application.first.orders)
  class Base
    def initialize(orders)
      @orders     = orders
      today       = Date.today
      @today      = group_orders(orders, today, today)
      @yesterday  = group_orders(orders, today - 1, today - 1)

      @this_week  = group_orders(orders, today.beginning_of_week, today)
      @last_week  = group_orders(orders, today.beginning_of_week - 7, today.end_of_week - 7)

      @this_month = group_orders(orders, today.beginning_of_month, today)
      @last_month = group_orders(orders, today.beginning_of_month - 1.month, today.end_of_month - 1.month)

      @this_year  = group_orders(orders, today.beginning_of_year, today)
      @last_year  = group_orders(orders, today.beginning_of_year - 1.year, today.end_of_year - 1.year)

      @total      = orders
    end

    def orders_count
      today      = @today.length
      yesterday  = @yesterday.length
      this_week  = @this_week.length
      last_week  = @last_week.length
      this_month = @this_month.length
      last_month = @last_month.length
      this_year  = @this_year.length
      last_year  = @last_year.length
      total      = @total.length

      decorate(today, yesterday, this_week, last_week, this_month,
               last_month, this_year, last_year, total)
    end

    def orders_revenue
      today      = @today.sum(:total_price)
      yesterday  = @yesterday.sum(:total_price)
      this_week  = @this_week.sum(:total_price)
      last_week  = @last_week.sum(:total_price)
      this_month = @this_month.sum(:total_price)
      last_month = @last_month.sum(:total_price)
      this_year  = @this_year.sum(:total_price)
      last_year  = @last_year.sum(:total_price)
      total      = @total.sum(:total_price)

      decorate(today, yesterday, this_week, last_week, this_month,
               last_month, this_year, last_year, total)
    end

    def orders_min_price
      today      = @today.minimum(:total_price)
      yesterday  = @yesterday.minimum(:total_price)
      this_week  = @this_week.minimum(:total_price)
      last_week  = @last_week.minimum(:total_price)
      this_month = @this_month.minimum(:total_price)
      last_month = @last_month.minimum(:total_price)
      this_year  = @this_year.minimum(:total_price)
      last_year  = @last_year.minimum(:total_price)
      total      = @total.minimum(:total_price)

      decorate(today, yesterday, this_week, last_week, this_month,
               last_month, this_year, last_year, total)
    end

    def orders_max_price
      today      = @today.maximum(:total_price)
      yesterday  = @yesterday.maximum(:total_price)
      this_week  = @this_week.maximum(:total_price)
      last_week  = @last_week.maximum(:total_price)
      this_month = @this_month.maximum(:total_price)
      last_month = @last_month.maximum(:total_price)
      this_year  = @this_year.maximum(:total_price)
      last_year  = @last_year.maximum(:total_price)
      total      = @total.maximum(:total_price)

      decorate(today, yesterday, this_week, last_week, this_month,
               last_month, this_year, last_year, total)
    end

    def orders_avg_price
      today      = round @today.average(:total_price)
      yesterday  = round @yesterday.average(:total_price)
      this_week  = round @this_week.average(:total_price)
      last_week  = round @last_week.average(:total_price)
      this_month = round @this_month.average(:total_price)
      last_month = round @last_month.average(:total_price)
      this_year  = round @this_year.average(:total_price)
      last_year  = round @last_year.average(:total_price)
      total      = round @total.average(:total_price)

      decorate(today, yesterday, this_week, last_week, this_month,
               last_month, this_year, last_year, total)
    end

    private

      def group_orders(serie,
                       start_date = start_date || 7.days.ago,
                       end_date   = end_date   || Time.zone.now)
        @start_date = start_date.to_time.midnight
        @end_date   = end_date.to_time.end_of_day

        serie.where(date: @start_date..@end_date)
      end

      def decorate(today, yesterday, this_week, last_week, this_month,
                   last_month, this_year, last_year, total)
        {
          today:      today,
          yesterday:  yesterday,
          this_week:  this_week,
          last_week:  last_week,
          this_month: this_month,
          last_month: last_month,
          this_year:  this_year,
          last_year:  last_year,
          total:      total
        }
      end

      def round(number)
        number.nil? ? nil : number.round(2)
      end

  end
end
