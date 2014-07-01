class AddTaxToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :tax, :decimal, precision: 11, scale: 2, default: 0
  end
end
