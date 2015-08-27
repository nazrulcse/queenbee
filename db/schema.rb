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

ActiveRecord::Schema.define(version: 20150827003147) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "applications", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "slug",               limit: 255
    t.string   "auth_token",         limit: 255
    t.boolean  "active",                         default: true
    t.text     "identicon"
    t.integer  "orders_count",                   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "locale",             limit: 255, default: "en"
    t.boolean  "subscription_based",             default: false
    t.jsonb    "metrics",                        default: {}
  end

  create_table "orders", force: :cascade do |t|
    t.string   "uid",             limit: 255
    t.datetime "date"
    t.string   "currency",        limit: 255
    t.decimal  "amount",                      precision: 11, scale: 2, default: 0.0
    t.decimal  "shipping",                    precision: 11, scale: 2, default: 0.0
    t.decimal  "total_price",                 precision: 11, scale: 2, default: 0.0
    t.boolean  "gift",                                                 default: false
    t.boolean  "coupon",                                               default: false
    t.string   "coupon_code",     limit: 255
    t.string   "country",         limit: 255
    t.string   "city",            limit: 255
    t.string   "url",             limit: 255
    t.string   "client_email",    limit: 255
    t.integer  "products_count",                                       default: 1
    t.integer  "application_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "keywords",        limit: 255
    t.integer  "week_day"
    t.integer  "month_day"
    t.integer  "hour"
    t.decimal  "tax",                         precision: 11, scale: 2, default: 0.0
    t.string   "source",          limit: 255
    t.datetime "subscribed_at"
    t.datetime "unsubscribed_at"
  end

  add_index "orders", ["application_id", "source"], name: "index_orders_on_application_id_and_source", using: :btree
  add_index "orders", ["application_id"], name: "index_orders_on_application_id", using: :btree
  add_index "orders", ["city"], name: "index_orders_on_city", using: :btree
  add_index "orders", ["country"], name: "index_orders_on_country", using: :btree
  add_index "orders", ["coupon"], name: "index_orders_on_coupon", using: :btree
  add_index "orders", ["coupon_code"], name: "index_orders_on_coupon_code", using: :btree
  add_index "orders", ["date"], name: "index_orders_on_date", using: :btree
  add_index "orders", ["gift"], name: "index_orders_on_gift", using: :btree
  add_index "orders", ["hour"], name: "index_orders_on_hour", using: :btree
  add_index "orders", ["keywords"], name: "index_orders_on_keywords", using: :btree
  add_index "orders", ["month_day"], name: "index_orders_on_month_day", using: :btree
  add_index "orders", ["week_day"], name: "index_orders_on_week_day", using: :btree

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
