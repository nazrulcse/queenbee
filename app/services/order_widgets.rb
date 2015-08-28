class OrderWidgets

	def initialize(application,
		             start_date = start_date || 7.days.ago,
		             end_date   = end_date   || Time.zone.now)
		@application = application
		@start_date  = start_date.to_time.midnight
		@end_date    = end_date.to_time.end_of_day
	end

	def orders
		@application.orders.where(date: @start_date..@end_date)
	end

	def period_in_days
		(@end_date.to_date - @start_date.to_date).to_i
	end

	def revenue
		orders.group_by_day(:date).sum(:total_price)
	end

	def total_revenue
		orders.sum(:total_price) || 0
	end

	def monthly_revenue
		orders.group_by_month(:date, format: "%h %Y").sum(:total_price)
	end

	def min_price
		orders.minimum(:total_price) || 0
	end

	def max_price
		orders.maximum(:total_price) || 0
	end

	def average_price
		orders.average(:total_price) || 0
	end

	def orders_count
	  orders.group_by_day(:date).count
	end

	def orders_average
		if orders.count > 0 && period_in_days > 0
			orders.count / period_in_days
		else
			0
		end
	end

	def orders_average_price
		orders.group_by_day(:date).average(:total_price)
	end

	def most_used_coupons
		orders.group(:coupon_code).count
	end

	def revenue_by_coupon
		orders.group(:coupon_code).sum(:total_price)
	end

	def products_count
		orders.group(:products_count).count
	end

	def products_average
		orders.average(:products_count) || 0
	end

	def sources
	  orders.group(:source).count
	end

	def top_clients
		orders.group(:client_email).limit(10).count
	end

	def top_countries
		orders.group(:country).count
	end

	def top_cities
		orders.group(:city).count
	end

	def daily_revenue_average
		if total_revenue > 0 && period_in_days > 0
			total_revenue / period_in_days
		else
			0
		end
	end

  def referral
  	orders.with_referral.length
  end

	def referrals
		orders.group(:referral).limit(10).count
	end

	# To get a specific time range, use:
  # User.group_by_day(:created_at, range: 2.weeks.ago.midnight..Time.now).count

  # To get the most recent time periods, use:
  # User.group_by_week(:created_at, last: 8).count # last 8 weeks
end
