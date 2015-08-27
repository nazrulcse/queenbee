class AddMetricsToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :metrics, :jsonb, default: {}
  end
end
