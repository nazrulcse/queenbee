class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string  :name
      t.string  :slug
      t.string  :auth_token
      t.boolean :active, default: true
      t.text    :identicon
      t.integer :orders_count, default: 0

      t.timestamps
    end
  end
end
