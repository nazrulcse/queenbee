module Metrics
  class Subscriptions < Base

    def user_churn
    end

    def mrr
      today      = round @today.inject(0) { |sum, order| sum + order.total_price }
      yesterday  = round @yesterday.inject(0) { |sum, order| sum + order.total_price }
      this_week  = round @this_week.inject(0) { |sum, order| sum + order.total_price }
      last_week  = round @last_week.inject(0) { |sum, order| sum + order.total_price }
      this_month = round @this_month.inject(0) { |sum, order| sum + order.total_price }
      last_month = round @last_month.inject(0) { |sum, order| sum + order.total_price }
      this_year  = round @this_year.inject(0) { |sum, order| sum + order.total_price }
      last_year  = round @last_year.inject(0) { |sum, order| sum + order.total_price }
      total      = round @total.inject(0) { |sum, order| sum + order.total_price }

      decorate(today, yesterday, this_week, last_week, this_month,
               last_month, this_year, last_year, total)
    end

    def arr
      today      = round @today.inject(0) { |sum, order| sum + order.total_price } * 12
      yesterday  = round @yesterday.inject(0) { |sum, order| sum + order.total_price } * 12
      this_week  = round @this_week.inject(0) { |sum, order| sum + order.total_price } * 12
      last_week  = round @last_week.inject(0) { |sum, order| sum + order.total_price } * 12
      this_month = round @this_month.inject(0) { |sum, order| sum + order.total_price } * 12
      last_month = round @last_month.inject(0) { |sum, order| sum + order.total_price } * 12
      this_year  = round @this_year.inject(0) { |sum, order| sum + order.total_price } * 12
      last_year  = round @last_year.inject(0) { |sum, order| sum + order.total_price } * 12
      total      = round @total.inject(0) { |sum, order| sum + order.total_price } * 12

      decorate(today, yesterday, this_week, last_week, this_month,
               last_month, this_year, last_year, total)
    end

    def cancellations
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

    def active_customers
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

    def churn
      today_date = Date.today
      today      = round @today.inject(0) { |sum, o| sum + (o.subscribed_at.to_date || today_date) - o.subscribed_at.to_date } / @today.length unless @today.length == 0
      yesterday  = round @yesterday.inject(0) { |sum, o| sum + (o.subscribed_at.to_date || today_date) - o.subscribed_at.to_date } / @yesterday.length unless @yesterday.length == 0
      this_week  = round @this_week.inject(0) { |sum, o| sum + (o.subscribed_at.to_date || today_date) - o.subscribed_at.to_date } / @this_week.length unless @this_week.length == 0
      last_week  = round @last_week.inject(0) { |sum, o| sum + (o.subscribed_at.to_date || today_date) - o.subscribed_at.to_date } / @last_week.length unless @last_week.length == 0
      this_month = round @this_month.inject(0) { |sum, o| sum + (o.subscribed_at.to_date || today_date) - o.subscribed_at.to_date } / @this_month.length unless @this_month.length == 0
      last_month = round @last_month.inject(0) { |sum, o| sum + (o.subscribed_at.to_date || today_date) - o.subscribed_at.to_date } / @last_month.length unless @this_week.length == 0
      this_year  = round @this_year.inject(0) { |sum, o| sum + (o.subscribed_at.to_date || today_date) - o.subscribed_at.to_date } / @this_year.length unless @this_year.length == 0
      last_year  = round @last_year.inject(0) { |sum, o| sum + (o.subscribed_at.to_date || today_date) - o.subscribed_at.to_date } / @last_year.length unless @last_year.length == 0
      total      = round @total.inject(0) { |sum, o| sum + (o.subscribed_at.to_date || today_date) - o.subscribed_at.to_date } / @total.length unless @total.length == 0

      decorate(today, yesterday, this_week, last_week, this_month,
               last_month, this_year, last_year, total)
    end

  end
end
