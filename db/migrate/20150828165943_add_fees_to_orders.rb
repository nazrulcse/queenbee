class AddFeesToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :fees, :decimal, precision: 11, scale: 2, default: 0
    add_column :orders, :referral, :string
  end
end
