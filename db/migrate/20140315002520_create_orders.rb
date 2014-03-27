class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
    	t.string   :uid
    	t.datetime :date
      t.string   :currency
    	t.decimal  :amount, precision: 11, scale: 2, default: 0
      t.decimal  :shipping, precision: 11, scale: 2, default: 0
      t.decimal  :total_price, precision: 11, scale: 2, default: 0
    	t.boolean  :gift, default: false
    	t.boolean  :coupon, default: false
    	t.string   :coupon_code
    	t.string   :country
    	t.string   :city
    	t.string   :url
    	t.string   :client_email
    	t.integer  :products_count, default: 1
      t.integer  :application_id

      t.timestamps
    end

    add_index :orders, :country
    add_index :orders, :city
    add_index :orders, :gift
    add_index :orders, :coupon
    add_index :orders, :coupon_code
    add_index :orders, :date
    add_index :orders, :application_id
  end
end
