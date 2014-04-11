class AddKeywordsToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :keywords, :string

  	add_index :orders, :keywords
  end
end
