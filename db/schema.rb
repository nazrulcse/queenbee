# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140316161635) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "orders", force: true do |t|
    t.string   "uid"
    t.string   "source"
    t.datetime "date"
    t.string   "currency"
    t.decimal  "amount",         precision: 11, scale: 2, default: 0.0
    t.decimal  "shipping",       precision: 11, scale: 2, default: 0.0
    t.decimal  "total_price",    precision: 11, scale: 2, default: 0.0
    t.boolean  "gift",                                    default: false
    t.boolean  "coupon",                                  default: false
    t.string   "coupon_code"
    t.string   "country"
    t.string   "city"
    t.string   "url"
    t.string   "client_email"
    t.integer  "products_count",                          default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["city"], name: "index_orders_on_city", using: :btree
  add_index "orders", ["country"], name: "index_orders_on_country", using: :btree
  add_index "orders", ["coupon"], name: "index_orders_on_coupon", using: :btree
  add_index "orders", ["coupon_code"], name: "index_orders_on_coupon_code", using: :btree
  add_index "orders", ["date"], name: "index_orders_on_date", using: :btree
  add_index "orders", ["gift"], name: "index_orders_on_gift", using: :btree
  add_index "orders", ["source"], name: "index_orders_on_source", using: :btree

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
