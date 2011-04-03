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

ActiveRecord::Schema.define(:version => 20110403211048) do

  create_table "categories", :force => true do |t|
    t.integer   "parent_id"
    t.string    "code"
    t.string    "title"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "feeds", :force => true do |t|
    t.integer   "user_id"
    t.string    "region"
    t.string    "category"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "filters", :force => true do |t|
    t.integer   "feed_id"
    t.string    "key"
    t.string    "value"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "items", :force => true do |t|
    t.integer   "feed_id"
    t.string    "title"
    t.string    "link"
    t.timestamp "published_at"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.float     "price"
    t.text      "summary"
    t.string    "location"
  end

  create_table "keywords", :force => true do |t|
    t.integer   "feed_id"
    t.string    "value"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "regions", :force => true do |t|
    t.string   "code"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string    "email"
    t.string    "encrypted_password", :limit => 128
    t.string    "salt",               :limit => 128
    t.string    "confirmation_token", :limit => 128
    t.string    "remember_token",     :limit => 128
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "first_name"
    t.string    "last_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
