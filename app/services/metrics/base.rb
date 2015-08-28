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

    def net_revenue
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

    def min_amount
      today      = round @today.minimum(:total_price)
      yesterday  = round @yesterday.minimum(:total_price)
      this_week  = round @this_week.minimum(:total_price)
      last_week  = round @last_week.minimum(:total_price)
      this_month = round @this_month.minimum(:total_price)
      last_month = round @last_month.minimum(:total_price)
      this_year  = round @this_year.minimum(:total_price)
      last_year  = round @last_year.minimum(:total_price)
      total      = round @total.minimum(:total_price)

      decorate(today, yesterday, this_week, last_week, this_month,
               last_month, this_year, last_year, total)
    end

    def max_amount
      today      = round @today.maximum(:total_price)
      yesterday  = round @yesterday.maximum(:total_price)
      this_week  = round @this_week.maximum(:total_price)
      last_week  = round @last_week.maximum(:total_price)
      this_month = round @this_month.maximum(:total_price)
      last_month = round @last_month.maximum(:total_price)
      this_year  = round @this_year.maximum(:total_price)
      last_year  = round @last_year.maximum(:total_price)
      total      = round @total.maximum(:total_price)

      decorate(today, yesterday, this_week, last_week, this_month,
               last_month, this_year, last_year, total)
    end

    def avg_amount
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

    def user_churn
    end

    def mrr
    end

    def arr
      # mrr * 12
    end

    def cancellations
      # must group by :unsubscribed_at ad not date
      today      = @today.unsubscribed.length
      yesterday  = @yesterday.unsubscribed.length
      this_week  = @this_week.unsubscribed.length
      last_week  = @last_week.unsubscribed.length
      this_month = @this_month.unsubscribed.length
      last_month = @last_month.unsubscribed.length
      this_year  = @this_year.unsubscribed.length
      last_year  = @last_year.unsubscribed.length
      total      = @total.unsubscribed.length

      decorate(today, yesterday, this_week, last_week, this_month,
               last_month, this_year, last_year, total)
    end

    def total_fees
      today      = round @today.sum(:fees)
      yesterday  = round @yesterday.sum(:fees)
      this_week  = round @this_week.sum(:fees)
      last_week  = round @last_week.sum(:fees)
      this_month = round @this_month.sum(:fees)
      last_month = round @last_month.sum(:fees)
      this_year  = round @this_year.sum(:fees)
      last_year  = round @last_year.sum(:fees)
      total      = round @total.sum(:fees)

      decorate(today, yesterday, this_week, last_week, this_month,
               last_month, this_year, last_year, total)
    end

    def active_customers
      today      = @today.recurring.length
      yesterday  = @yesterday.recurring.length
      this_week  = @this_week.recurring.length
      last_week  = @last_week.recurring.length
      this_month = @this_month.recurring.length
      last_month = @last_month.recurring.length
      this_year  = @this_year.recurring.length
      last_year  = @last_year.recurring.length
      total      = @total.recurring.length

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
