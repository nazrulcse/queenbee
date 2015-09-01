module Metrics

  # Metrics::Base.new(Application.first.orders)
  class Base
    def initialize(orders, opts = {})
      @orders     = orders
      today       = Date.today
      @today      = group_orders(orders, today, today, opts[:group_by])
      @yesterday  = group_orders(orders, today - 1.day, today - 1.day, opts[:group_by])

      @this_week  = group_orders(orders, today.beginning_of_week, today, opts[:group_by])
      @last_week  = group_orders(orders, today.beginning_of_week - 7.days, today.end_of_week - 7.days, opts[:group_by])

      @this_month = group_orders(orders, today.beginning_of_month, today, opts[:group_by])
      @last_month = group_orders(orders, today.beginning_of_month - 1.month, today.end_of_month - 1.month, opts[:group_by])

      @this_year  = group_orders(orders, today.beginning_of_year, today, opts[:group_by])
      @last_year  = group_orders(orders, today.beginning_of_year - 1.year, today.end_of_year - 1.year, opts[:group_by])

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

    private

      def group_orders(serie,
                       start_date = start_date || 7.days.ago,
                       end_date   = end_date   || Time.zone.now,
                       group_by   = 'date' )
        @start_date = start_date.to_time.midnight
        @end_date   = end_date.to_time.end_of_day

        if group_by == 'unsubscribed_at'
          serie.where(unsubscribed_at: @start_date..@end_date)
        elsif group_by == 'subscribed_at'
          serie.where(subscribed_at: @start_date..@end_date)
        else
          serie.where(date: @start_date..@end_date)
        end
      end

      def decorate(today, yesterday, this_week, last_week, this_month,
                   last_month, this_year, last_year, total)

        args = method(__method__).parameters.map { |arg| arg[1] }
        args.each do |arg|
          arg.nil? ? 0 : arg
          # puts arg if arg.nil?
        end

        {
          today:      { value: today, percentage_change: percentage_change(yesterday, today) },
          yesterday:  { value: yesterday },
          this_week:  { value: this_week, percentage_change: percentage_change(last_week, this_week) },
          last_week:  { value: last_week },
          this_month: { value: this_month, percentage_change: percentage_change(last_month, this_month) },
          last_month: { value: last_month },
          this_year:  { value: this_year, percentage_change: percentage_change(last_year, this_year) },
          last_year:  { value: last_year },
          total:      { value: total }
        }
      end

      def round(number)
        number.nil? ? nil : number.round(2)
      end

      def percentage_change(old_value, new_value)
        if !old_value.nil? && !new_value.nil?
          unless old_value == 0
            round( (new_value - old_value) / old_value.to_f * 100 )
          end
        end
      end

  end
end
