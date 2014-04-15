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

ActiveRecord::Schema.define(:version => 20140415084735) do

  create_table "concerns", :primary_key => "concern_id", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "satlevels", :primary_key => "satlevel_id", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_concerns", :id => false, :force => true do |t|
    t.integer  "service_id", :default => 0, :null => false
    t.integer  "concern_id", :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :primary_key => "service_id", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vote_concerns", :id => false, :force => true do |t|
    t.integer  "vote_id",    :default => 0, :null => false
    t.integer  "concern_id", :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", :primary_key => "vote_id", :force => true do |t|
    t.string   "client_id"
    t.integer  "satlevel_id"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
