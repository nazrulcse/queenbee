class AddDateAndHoursToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :week_day,  :integer
    add_column :orders, :month_day, :integer
    add_column :orders, :hour,      :integer

    add_index  :orders, :week_day
    add_index  :orders, :month_day
    add_index  :orders, :hour

    Order.all.each do |order|
    	order.week_day   = order.date.to_date.cwday if order.date.present?
      order.month_day  = order.date.day if order.date.present?
      order.hour       = order.date.to_time.hour if order.date.present?
      order.currency   = order.currency.downcase
      order.save!
    end

  end
end
