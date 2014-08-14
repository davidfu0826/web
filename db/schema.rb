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

ActiveRecord::Schema.define(version: 20140813120355) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contact_forms", force: true do |t|
    t.integer  "page_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "events", force: true do |t|
    t.string   "title_sv"
    t.string   "description_sv"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_group_id"
    t.string   "title_en"
    t.string   "description_en"
  end

  add_index "events", ["event_group_id"], name: "index_events_on_event_group_id", using: :btree

  create_table "images", force: true do |t|
    t.string   "image_uid"
    t.string   "image_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nav_items", force: true do |t|
    t.string   "title_sv"
    t.integer  "page_id"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title_en"
    t.integer  "position"
  end

  create_table "pages", force: true do |t|
    t.string   "title_sv"
    t.text     "content_sv"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "title_en"
    t.text     "content_en"
  end

  add_index "pages", ["user_id"], name: "index_pages_on_user_id", using: :btree

  create_table "pages_users", force: true do |t|
    t.integer  "page_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title_sv"
    t.text     "content_sv"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title_en"
    t.text     "content_en"
    t.integer  "image_id"
  end

  add_index "posts", ["image_id"], name: "index_posts_on_image_id", using: :btree

  create_table "questions", force: true do |t|
    t.string   "content"
    t.integer  "contact_form_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "name"
    t.string   "phonenumber"
    t.string   "title_sv"
    t.integer  "role"
    t.string   "title_en"
    t.integer  "locale"
    t.string   "profile_image_uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
