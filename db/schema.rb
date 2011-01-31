# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110131032745) do

  create_table "admin_configs", :force => true do |t|
    t.string    "admin_password"
    t.boolean   "picks_editable"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string    "name",       :null => false
    t.integer   "points",     :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "year"
  end

  create_table "entries", :force => true do |t|
    t.integer  "player_id",  :null => false
    t.integer  "year",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "films", :force => true do |t|
    t.string    "name",       :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "nominees", :force => true do |t|
    t.string    "name",        :null => false
    t.integer   "film_id",     :null => false
    t.integer   "category_id", :null => false
    t.boolean   "is_winner"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "picks", :force => true do |t|
    t.integer  "category_id", :null => false
    t.integer  "nominee_id"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entry_id"
  end

  create_table "players", :force => true do |t|
    t.string    "name",       :null => false
    t.string    "password",   :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "players", ["name"], :name => "index_players_on_name", :unique => true

end
