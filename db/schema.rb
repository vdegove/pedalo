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

ActiveRecord::Schema.define(version: 2018_12_13_140439) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.float "longitude"
    t.float "latitude"
    t.string "contact_phone"
    t.string "contact_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "company_package_types", force: :cascade do |t|
    t.bigint "package_type_id"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_package_types_on_company_id"
    t.index ["package_type_id"], name: "index_company_package_types_on_package_type_id"
  end

  create_table "deliveries", force: :cascade do |t|
    t.bigint "company_id"
    t.string "recipient_name"
    t.string "recipient_phone"
    t.string "address"
    t.float "longitude"
    t.float "latitude"
    t.datetime "complete_after"
    t.datetime "complete_before"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.datetime "picked_up_at"
    t.datetime "delivered_at"
    t.string "onfleet_task_dropoff"
    t.string "tracking_url_dropoff"
    t.string "onfleet_task_pickup"
    t.string "tracking_url_pickup"
    t.string "driver_name"
    t.string "driver_phone"
    t.string "driver_photo"
    t.index ["company_id"], name: "index_deliveries_on_company_id"
  end

  create_table "delivery_packages", force: :cascade do |t|
    t.bigint "delivery_id"
    t.bigint "package_type_id"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["delivery_id"], name: "index_delivery_packages_on_delivery_id"
    t.index ["package_type_id"], name: "index_delivery_packages_on_package_type_id"
  end

  create_table "package_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.boolean "admin", default: false, null: false
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "company_package_types", "companies"
  add_foreign_key "company_package_types", "package_types"
  add_foreign_key "deliveries", "companies"
  add_foreign_key "delivery_packages", "deliveries"
  add_foreign_key "delivery_packages", "package_types"
  add_foreign_key "users", "companies"
end
