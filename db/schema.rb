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

ActiveRecord::Schema.define(:version => 20120715230014) do

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "album_number"
    t.integer  "mp3_size",     :default => 0
    t.integer  "m4a_size",     :default => 0
  end

  create_table "extracks_emails", :force => true do |t|
    t.string   "email",      :default => ""
    t.string   "link_hash",  :default => "0"
    t.string   "mp3_hash",   :default => "0"
    t.integer  "visited_by", :default => 0
    t.string   "origin_ip",  :default => "0"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fan_emails", :force => true do |t|
    t.string   "email",      :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fan_locations", :force => true do |t|
    t.string   "ip_address",   :default => "", :null => false
    t.string   "city",         :default => ""
    t.string   "state",        :default => ""
    t.string   "country_code", :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fan_locations", ["city", "state"], :name => "index_fan_locations_on_city_and_state"
  add_index "fan_locations", ["state", "country_code"], :name => "index_fan_locations_on_state_and_country_code"

  create_table "tracks", :force => true do |t|
    t.string   "name",             :default => ""
    t.integer  "album_id",         :default => 0
    t.integer  "download_count",   :default => 0
    t.string   "download_referer", :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "local_name"
    t.integer  "track_number"
  end

  create_table "tracks_email", :force => true do |t|
    t.string   "email",      :default => ""
    t.string   "link_hash",  :default => "0"
    t.string   "mp3_hash",   :default => "0"
    t.integer  "visited_by", :default => 0
    t.string   "origin_ip",  :default => "0"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
