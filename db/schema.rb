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

ActiveRecord::Schema.define(version: 20170226045241) do

  create_table "categories", primary_key: "pkcategory", force: :cascade do |t|
    t.text     "description"
    t.text     "note"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["pkcategory"], name: "index_categories_on_pkcategory", unique: true
  end

  create_table "list_price_details", force: :cascade do |t|
    t.string   "listprice"
    t.integer  "category_id"
    t.integer  "service_id"
    t.integer  "list_price_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["category_id"], name: "index_list_price_details_on_category_id"
    t.index ["list_price_id"], name: "index_list_price_details_on_list_price_id"
    t.index ["service_id"], name: "index_list_price_details_on_service_id"
  end

  create_table "list_prices", primary_key: "pklist", force: :cascade do |t|
    t.boolean  "list_default_mark"
    t.string   "list_description"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["pklist"], name: "index_list_prices_on_pklist", unique: true
  end

  create_table "services", primary_key: "pkservice", force: :cascade do |t|
    t.text     "description"
    t.text     "notes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["pkservice"], name: "index_services_on_pkservice", unique: true
  end

end
