class AddSubscriptionToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :subscribed_at, :datetime
    add_column :orders, :unsubscribed_at, :datetime
  end
end
