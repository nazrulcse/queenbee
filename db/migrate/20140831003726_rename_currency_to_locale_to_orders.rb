class RenameCurrencyToLocaleToOrders < ActiveRecord::Migration
  def change
  	rename_column :applications, :default_currency,   :locale
  	add_column    :applications, :subscription_based, :boolean, default: false
  end
end
