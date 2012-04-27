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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120427140057) do

  create_table "redeemables", :force => true do |t|
    t.string   "code"
    t.integer  "share_id"
    t.integer  "redeemer_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "redeemables", ["redeemer_id"], :name => "index_redeemables_on_redeemer_id"
  add_index "redeemables", ["share_id"], :name => "index_redeemables_on_share_id"

  create_table "shares", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "share_code"
    t.boolean  "need_tweet"
    t.boolean  "promoted"
    t.integer  "owner_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.text     "description"
    t.text     "description_html"
    t.boolean  "disabled"
  end

  add_index "shares", ["owner_id"], :name => "index_shares_on_owner_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "nickname"
    t.string   "token"
    t.string   "secret"
  end

  add_index "users", ["uid"], :name => "index_users_on_uid"

end
