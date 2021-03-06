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

ActiveRecord::Schema.define(:version => 20130624062732) do

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.integer  "artist_id"
    t.integer  "track_count"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "artist_aliases", :force => true do |t|
    t.string   "name"
    t.integer  "artist_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tracks", :force => true do |t|
    t.string   "name"
    t.integer  "artist_id"
    t.integer  "album_id"
    t.string   "track_artist"
    t.integer  "track_no"
    t.string   "composer"
    t.integer  "total_time"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "user_tracks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "track_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "delete_flg"
    t.integer  "track_rate"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "library_path"
    t.string   "key"
    t.boolean  "complete"
    t.datetime "created_on"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
