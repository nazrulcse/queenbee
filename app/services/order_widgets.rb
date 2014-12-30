class OrderWidgets

	def initialize(application,
		             start_date = start_date || 7.days.ago,
		             end_date   = end_date   || Time.zone.now)
		@application = application
		@start_date  = start_date.to_time.midnight
		@end_date    = end_date.to_time.end_of_day
		@orders      = @application.orders.where(date: @start_date..@end_date)
	  puts "**** found #{@orders.length} orders ****"
	end

	def total_price
		@orders.sum(:total_price) || 0
	end

	def order_min_price
		@orders.minimum(:total_price) || 0
    # @orders.group_by_day(:date, last: period || @period).minimum(:total_price)
	end

	def order_max_price
		@orders.maximum(:total_price) || 0
	end

	def order_average_price
		@orders.average(:total_price) || 0
	end

	def orders_count
		@orders.group_by_day(:date).count
	end

	def orders_average_price
		@orders.group_by_day(:date).average(:total_price)
	end

	def coupons
		@orders.group(:coupon_code).count
	end

	def products_count
		@orders.group(:products_count).count
	end

	def sources
		@orders.group(:source).count
	end

	def top_clients
		@orders.group(:client_email).limit(10).count
	end

	# To get a specific time range, use:
  # User.group_by_day(:created_at, range: 2.weeks.ago.midnight..Time.now).count

  # To get the most recent time periods, use:
  # User.group_by_week(:created_at, last: 8).count # last 8 weeks
end