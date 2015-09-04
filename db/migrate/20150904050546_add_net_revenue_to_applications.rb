class AddNetRevenueToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :net_revenue, :jsonb, default: {}
  end
end
