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

ActiveRecord::Schema.define(:version => 20120712061419) do

  create_table "apps", :force => true do |t|
    t.text     "bio"
    t.string   "email"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "personal"
    t.string   "name"
    t.string   "uid"
    t.string   "picture"
    t.text     "education"
    t.text     "work"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "token"
  end

  create_table "apps_tags", :id => false, :force => true do |t|
    t.integer "app_id"
    t.integer "tag_id"
  end

  add_index "apps_tags", ["app_id", "tag_id"], :name => "index_apps_tags_on_app_id_and_tag_id"
  add_index "apps_tags", ["tag_id", "app_id"], :name => "index_apps_tags_on_tag_id_and_app_id"

  create_table "conversations", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "mentee_id"
    t.integer  "mentor_id"
  end

  create_table "conversations_tags", :id => false, :force => true do |t|
    t.integer "conversation_id"
    t.integer "tag_id"
  end

  add_index "conversations_tags", ["conversation_id", "tag_id"], :name => "index_conversations_tags_on_conversation_id_and_tag_id"
  add_index "conversations_tags", ["tag_id", "conversation_id"], :name => "index_conversations_tags_on_tag_id_and_conversation_id"

  create_table "emails", :force => true do |t|
    t.text     "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "mentor"
  end

  create_table "invitations", :force => true do |t|
    t.string   "token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "mentee_apps", :force => true do |t|
    t.string   "email"
    t.string   "info"
    t.string   "token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "mentees", :force => true do |t|
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "u_id"
    t.integer  "grade"
    t.string   "picture_url"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "access_token"
    t.string   "birthday"
    t.string   "authentication_token"
  end

  add_index "mentees", ["email"], :name => "index_mentees_on_email", :unique => true
  add_index "mentees", ["reset_password_token"], :name => "index_mentees_on_reset_password_token", :unique => true

  create_table "mentees_tags", :id => false, :force => true do |t|
    t.integer "mentee_id"
    t.integer "tag_id"
  end

  add_index "mentees_tags", ["mentee_id", "tag_id"], :name => "index_mentees_tags_on_mentee_id_and_tag_id"
  add_index "mentees_tags", ["tag_id", "mentee_id"], :name => "index_mentees_tags_on_tag_id_and_mentee_id"

  create_table "mentors", :force => true do |t|
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "u_id"
    t.integer  "grade"
    t.string   "picture_url"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "access_token"
    t.string   "birthday"
    t.string   "authentication_token"
  end

  add_index "mentors", ["email"], :name => "index_mentors_on_email", :unique => true
  add_index "mentors", ["reset_password_token"], :name => "index_mentors_on_reset_password_token", :unique => true

  create_table "mentors_tags", :id => false, :force => true do |t|
    t.integer "mentor_id"
    t.integer "tag_id"
  end

  add_index "mentors_tags", ["mentor_id", "tag_id"], :name => "index_mentors_tags_on_mentor_id_and_tag_id"
  add_index "mentors_tags", ["tag_id", "mentor_id"], :name => "index_mentors_tags_on_tag_id_and_mentor_id"

  create_table "messages", :force => true do |t|
    t.text     "text",            :limit => 255
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "conversation_id"
    t.string   "owner_type"
    t.string   "video"
  end

  create_table "tags", :force => true do |t|
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
