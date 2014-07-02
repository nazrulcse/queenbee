class AddSourceToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :source, :string

    add_index :orders, [:application_id, :source]

    Order.update_all(source: 'website')
  end
end
