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

ActiveRecord::Schema.define(version: 20180716072238) do

  create_table "bookings", force: :cascade do |t|
    t.date     "checkin"
    t.date     "checkout"
    t.integer  "rooms"
    t.integer  "roomtype_id"
    t.integer  "customer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "email"
    t.string   "phoneno"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hotels", force: :cascade do |t|
    t.string   "hotelname"
    t.string   "hoteltype"
    t.string   "chainname"
    t.integer  "floor"
    t.string   "currency"
    t.float    "rating"
    t.integer  "year"
    t.integer  "checkinhrsfrom"
    t.integer  "checkinminfrom"
    t.string   "checkinampmfrom"
    t.integer  "checkinhrsto"
    t.integer  "checkinminto"
    t.string   "checkinampmto"
    t.integer  "checkouthrsfrom"
    t.integer  "checkoutminfrom"
    t.string   "checkoutampmfrom"
    t.integer  "checkouthrsto"
    t.integer  "checkoutminto"
    t.string   "checkoutampmto"
    t.string   "streetname"
    t.string   "buildingname"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zipcode"
    t.text     "basic"
    t.text     "media"
    t.text     "food"
    t.text     "disability"
    t.text     "entertainment"
    t.text     "description"
    t.text     "policies"
    t.string   "images"
    t.string   "landmark"
    t.string   "phnno1"
    t.string   "phnno2"
    t.string   "landline"
    t.string   "email"
    t.string   "accholder"
    t.string   "accno"
    t.string   "gstno"
    t.string   "ifsccode"
    t.string   "panno"
  end

  add_index "hotels", ["user_id"], name: "index_hotels_on_user_id"

  create_table "pricings", force: :cascade do |t|
    t.text     "price"
    t.integer  "hotel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pricings", ["hotel_id"], name: "index_pricings_on_hotel_id"

  create_table "roomtypes", force: :cascade do |t|
    t.integer  "rooms"
    t.string   "beds"
    t.integer  "baseadults"
    t.integer  "basechildren",    default: 0
    t.boolean  "tv",              default: false
    t.integer  "hotel_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "typename"
    t.integer  "maximumadults",   default: 0
    t.integer  "maximumchildren", default: 0
    t.integer  "infants",         default: 0
    t.integer  "maximumguests",   default: 0
    t.integer  "extrabed",        default: 0
    t.text     "basic"
    t.text     "restroom"
    t.text     "services"
    t.text     "view"
    t.string   "images"
  end

  add_index "roomtypes", ["hotel_id"], name: "index_roomtypes_on_hotel_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "firstname"
    t.string   "lastname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
