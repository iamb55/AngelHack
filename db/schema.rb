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

ActiveRecord::Schema.define(:version => 20120624063814) do

  create_table "conversations", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "mentee_id"
    t.integer  "mentor_id"
  end

  create_table "emails", :force => true do |t|
    t.text     "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "mentor"
  end

  create_table "mentees", :force => true do |t|
    t.string   "birthday"
    t.string   "access_token"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "picture_url"
    t.integer  "grade"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "u_id"
  end

  create_table "mentors", :force => true do |t|
    t.string   "birthday"
    t.string   "access_token"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "picture_url"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "u_id"
  end

  create_table "messages", :force => true do |t|
    t.string   "value"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "conversation_id"
    t.string   "owner_type"
    t.string   "data_type",       :default => "text"
  end

  create_table "tags", :force => true do |t|
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
