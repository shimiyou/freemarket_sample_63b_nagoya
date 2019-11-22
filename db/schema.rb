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

ActiveRecord::Schema.define(version: 20191121122610) do

  create_table "items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                    null: false
    t.integer  "brand_id"
    t.string   "name",                       null: false
    t.integer  "price",                      null: false
    t.text     "description",  limit: 65535, null: false
    t.string   "size",                       null: false
    t.string   "state",                      null: false
    t.integer  "like_count"
    t.string   "postage_side",               null: false
    t.string   "send_method",                null: false
    t.string   "post",                       null: false
    t.string   "send_date",                  null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",           null: false
    t.string   "password",        null: false
    t.string   "nickname",        null: false
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "first_name_kana", null: false
    t.string   "last_name_kana",  null: false
    t.integer  "phone_number",    null: false
    t.date     "birthday",        null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
