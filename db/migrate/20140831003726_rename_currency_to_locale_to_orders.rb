class RenameCurrencyToLocaleToOrders < ActiveRecord::Migration
  def change
  	rename_column  :applications, :default_currency,   :locale
  	change_column  :applications, :locale,             :string,  default: 'en'
  	add_column     :applications, :subscription_based, :boolean, default: false
  end
end
