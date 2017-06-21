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

ActiveRecord::Schema.define(version: 20170621063723) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contact_forms", force: :cascade do |t|
    t.integer  "page_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.index ["page_id"], name: "index_contact_forms_on_page_id", using: :btree
    t.index ["user_id"], name: "index_contact_forms_on_user_id", using: :btree
  end

  create_table "documents", force: :cascade do |t|
    t.string   "title_sv"
    t.string   "title_en"
    t.text     "description_sv"
    t.text     "description_en"
    t.integer  "category",       default: -1, null: false
    t.text     "file_sv"
    t.text     "file_en"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "meeting_id"
    t.index ["category"], name: "index_documents_on_category", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "title_sv"
    t.string   "description_sv"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_group_id"
    t.string   "title_en"
    t.string   "description_en"
    t.string   "place"
    t.string   "facebook"
    t.index ["event_group_id"], name: "index_events_on_event_group_id", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "file"
    t.string   "file_name"
  end

  create_table "meeting_documents", force: :cascade do |t|
    t.integer  "meeting_id",              null: false
    t.integer  "document_id"
    t.integer  "kind",        default: 0, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "file_en"
    t.string   "file_sv"
    t.index ["document_id"], name: "index_meeting_documents_on_document_id", using: :btree
    t.index ["kind"], name: "index_meeting_documents_on_kind", using: :btree
    t.index ["meeting_id"], name: "index_meeting_documents_on_meeting_id", using: :btree
  end

  create_table "meetings", force: :cascade do |t|
    t.string   "title",                    null: false
    t.string   "year",                     null: false
    t.integer  "ranking",      default: 0, null: false
    t.integer  "kind",         default: 0, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.date     "meeting_date"
    t.index ["kind"], name: "index_meetings_on_kind", using: :btree
  end

  create_table "nav_items", force: :cascade do |t|
    t.string   "title_sv"
    t.integer  "page_id"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title_en"
    t.integer  "position"
    t.integer  "nav_item_type", default: 0, null: false
    t.string   "link"
    t.index ["page_id"], name: "index_nav_items_on_page_id", using: :btree
    t.index ["parent_id"], name: "index_nav_items_on_parent_id", using: :btree
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title_sv"
    t.text     "content_sv"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title_en"
    t.text     "content_en"
    t.integer  "image_id"
    t.index ["image_id"], name: "index_pages_on_image_id", using: :btree
  end

  create_table "pages_users", force: :cascade do |t|
    t.integer  "page_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["page_id"], name: "index_pages_users_on_page_id", using: :btree
    t.index ["user_id"], name: "index_pages_users_on_user_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title_sv"
    t.text     "content_sv"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title_en"
    t.text     "content_en"
    t.integer  "image_id"
    t.index ["image_id"], name: "index_posts_on_image_id", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.string   "content"
    t.integer  "contact_form_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["contact_form_id"], name: "index_questions_on_contact_form_id", using: :btree
  end

  create_table "sabbatical_officers", force: :cascade do |t|
    t.string   "description_en"
    t.string   "description_sv"
    t.string   "email",          null: false
    t.string   "image"
    t.string   "name",           null: false
    t.string   "phone",          null: false
    t.integer  "position"
    t.string   "role_en",        null: false
    t.string   "role_sv",        null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["tag_id", "taggable_type"], name: "index_taggings_on_tag_id_and_taggable_type", using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color"
  end

  create_table "uploads", force: :cascade do |t|
    t.string   "file_name"
    t.string   "file_uid",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "image_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                   default: "", null: false
    t.string   "encrypted_password",      default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,  null: false
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
    t.string   "profile_image_thumb_uid"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "documents", "meetings"
  add_foreign_key "meeting_documents", "documents"
  add_foreign_key "meeting_documents", "meetings"
end
