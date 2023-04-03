# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_04_03_041834) do
  create_table "active_admin_comments", charset: "utf8mb4", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "api_configurations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "exchange_id", null: false
    t.string "version"
    t.string "base_endpoint"
    t.integer "rate"
    t.string "official_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exchange_id"], name: "index_api_configurations_on_exchange_id"
  end

  create_table "currencies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.string "website"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exchanges", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "exchange_klass"
  end

  create_table "notification_rules", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "rule"
    t.string "description"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ticker_pairs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "currency_id", null: false
    t.bigint "first_ticker_id"
    t.bigint "second_ticker_id"
    t.string "scheduler"
    t.string "tele_channel_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "scheduled_sidekiq_job_id"
    t.integer "status", default: 0
    t.float "spread"
    t.datetime "deleted_at"
    t.datetime "last_run_at"
    t.float "spread_threshold_alert", default: 0.0
    t.float "withdraw_fee", default: 0.0
    t.float "deposit_fee", default: 0.0
    t.string "notification_interval"
    t.index ["currency_id"], name: "index_ticker_pairs_on_currency_id"
    t.index ["first_ticker_id"], name: "index_ticker_pairs_on_first_ticker_id"
    t.index ["second_ticker_id"], name: "index_ticker_pairs_on_second_ticker_id"
    t.index ["user_id"], name: "index_ticker_pairs_on_user_id"
  end

  create_table "tickers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "exchange_id", null: false
    t.string "base_currency"
    t.string "quote_currency"
    t.float "last_price"
    t.float "bid_price"
    t.float "ask_price"
    t.float "last_24h_volume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exchange_id"], name: "index_tickers_on_exchange_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "watch_lists", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "currency_id", null: false
    t.bigint "user_id", null: false
    t.string "schedule"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "spread_threshold_alert", default: 1.5
    t.float "spread"
    t.string "notification_interval"
    t.index ["currency_id"], name: "index_watch_lists_on_currency_id"
    t.index ["user_id"], name: "index_watch_lists_on_user_id"
  end

  add_foreign_key "api_configurations", "exchanges"
  add_foreign_key "ticker_pairs", "currencies"
  add_foreign_key "ticker_pairs", "tickers", column: "first_ticker_id"
  add_foreign_key "ticker_pairs", "tickers", column: "second_ticker_id"
  add_foreign_key "ticker_pairs", "users"
  add_foreign_key "tickers", "exchanges"
  add_foreign_key "watch_lists", "currencies"
  add_foreign_key "watch_lists", "users"
end
