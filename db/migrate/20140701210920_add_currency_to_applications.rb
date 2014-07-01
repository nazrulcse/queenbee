class AddCurrencyToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :default_currency, :string
  end
end
