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

ActiveRecord::Schema.define(version: 20160704084056) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "adminusers", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "adminusers", ["email"], name: "index_adminusers_on_email", unique: true, using: :btree
  add_index "adminusers", ["reset_password_token"], name: "index_adminusers_on_reset_password_token", unique: true, using: :btree

  create_table "app_version", primary_key: "version_code", force: :cascade do |t|
    t.string   "version_name", limit: 64
    t.boolean  "force_update"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "banks", force: :cascade do |t|
    t.string  "bank_name", limit: 45
    t.integer "bank_code", limit: 4
  end

  create_table "devices", force: :cascade do |t|
    t.string   "uuid",       limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "draw_pool", force: :cascade do |t|
    t.string  "path",    limit: 64
    t.integer "post_id", limit: 4
  end

  add_index "draw_pool", ["post_id"], name: "050_idx", using: :btree

  create_table "facebook_user", force: :cascade do |t|
    t.string   "provider",         limit: 255
    t.string   "uid",              limit: 255
    t.string   "name",             limit: 255
    t.string   "email",            limit: 255
    t.string   "oauth_token",      limit: 255
    t.datetime "oauth_expires_at"
  end

  create_table "faq", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.string   "title",      limit: 255
    t.text     "content",    limit: 4294967295
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "image_pool", force: :cascade do |t|
    t.string  "path",    limit: 64
    t.integer "user_id", limit: 4
  end

  add_index "image_pool", ["user_id"], name: "011_idx", using: :btree

  create_table "notice", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 4294967295
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "pay_log", force: :cascade do |t|
    t.string   "pay_key",    limit: 64
    t.integer  "user_id",    limit: 4
    t.integer  "post_id",    limit: 4
    t.integer  "item_id",    limit: 8
    t.string   "imp",        limit: 255
    t.string   "merchant",   limit: 255
    t.string   "memo",       limit: 255
    t.string   "pay_status", limit: 255
    t.string   "tel",        limit: 63
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pay_term", force: :cascade do |t|
    t.string   "term_code",    limit: 8
    t.text     "term_content", limit: 4294967295
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "privacy_term", force: :cascade do |t|
    t.string   "term_code",    limit: 8
    t.text     "term_content", limit: 4294967295
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "push_configurations", force: :cascade do |t|
    t.string   "type",        limit: 255,                   null: false
    t.string   "app",         limit: 255,                   null: false
    t.text     "properties",  limit: 65535
    t.boolean  "enabled",                   default: false, null: false
    t.integer  "connections", limit: 4,     default: 1,     null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "push_feedback", force: :cascade do |t|
    t.string   "app",          limit: 255,                   null: false
    t.string   "device",       limit: 255,                   null: false
    t.string   "type",         limit: 255,                   null: false
    t.string   "follow_up",    limit: 255,                   null: false
    t.datetime "failed_at",                                  null: false
    t.boolean  "processed",                  default: false, null: false
    t.datetime "processed_at"
    t.text     "properties",   limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "push_feedback", ["processed"], name: "index_push_feedback_on_processed", using: :btree

  create_table "push_messages", force: :cascade do |t|
    t.string   "app",               limit: 255,                   null: false
    t.string   "device",            limit: 255,                   null: false
    t.string   "type",              limit: 255,                   null: false
    t.text     "properties",        limit: 65535
    t.boolean  "delivered",                       default: false, null: false
    t.datetime "delivered_at"
    t.boolean  "failed",                          default: false, null: false
    t.datetime "failed_at"
    t.integer  "error_code",        limit: 4
    t.string   "error_description", limit: 255
    t.datetime "deliver_after"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "push_messages", ["delivered", "failed", "deliver_after"], name: "index_push_messages_on_delivered_and_failed_and_deliver_after", using: :btree

  create_table "push_onoff", force: :cascade do |t|
    t.boolean "onoff", default: false, null: false
  end

  create_table "reward_item", force: :cascade do |t|
    t.integer "item_code", limit: 8
    t.string  "name",      limit: 255
    t.integer "price",     limit: 8
    t.text    "image",     limit: 65535
  end

  create_table "share_log", force: :cascade do |t|
    t.integer  "post_id",    limit: 4, null: false
    t.string   "share_type", limit: 8, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "share_log", ["post_id"], name: "007_idx", using: :btree

  create_table "term", force: :cascade do |t|
    t.string   "term_code",    limit: 8
    t.text     "term_content", limit: 4294967295
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "token", force: :cascade do |t|
    t.string  "utoken",  limit: 255
    t.integer "user_id", limit: 8
  end

  create_table "univ_category", force: :cascade do |t|
    t.string  "univ_code",     limit: 25
    t.string  "univ_name",     limit: 255
    t.string  "univ_area",     limit: 255
    t.string  "univ_zip",      limit: 63
    t.text    "univ_addr",     limit: 16777215
    t.integer "student_total", limit: 4
    t.integer "student_now",   limit: 4
    t.integer "student_leave", limit: 4
  end

  create_table "user", force: :cascade do |t|
    t.string   "email",          limit: 255
    t.string   "password",       limit: 255
    t.string   "name",           limit: 64,  null: false
    t.string   "facebook_token", limit: 255
    t.integer  "profile_img",    limit: 4
    t.string   "user_token",     limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "wanted_board", force: :cascade do |t|
    t.integer  "univ_id",       limit: 4
    t.datetime "witness_date"
    t.boolean  "is_place_maps"
    t.string   "witness_place", limit: 255
    t.string   "target_gen",    limit: 1
    t.text     "talk_to",       limit: 16777215
    t.string   "reward",        limit: 16
    t.integer  "user_id",       limit: 4
    t.integer  "count_share",   limit: 4,                                 default: 0
    t.string   "draw_img",      limit: 255
    t.integer  "choosed_id",    limit: 4
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.decimal  "lat",                            precision: 10, scale: 6
    t.decimal  "lon",                            precision: 10, scale: 6
  end

  add_index "wanted_board", ["univ_id"], name: "004_idx", using: :btree
  add_index "wanted_board", ["user_id"], name: "001_idx", using: :btree

  create_table "wanted_comment", force: :cascade do |t|
    t.integer  "wanted_board_id", limit: 4
    t.integer  "user_id",         limit: 4
    t.text     "content",         limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "wanted_comment", ["user_id"], name: "002_idx", using: :btree
  add_index "wanted_comment", ["wanted_board_id"], name: "003_idx", using: :btree

  create_table "withdraw", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "bank_id",      limit: 4
    t.integer  "sum",          limit: 4
    t.string   "bank_account", limit: 64
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "withdraw", ["bank_id"], name: "009_idx", using: :btree
  add_index "withdraw", ["user_id"], name: "008_idx", using: :btree

  add_foreign_key "draw_pool", "wanted_board", column: "post_id", name: "050"
  add_foreign_key "draw_pool", "wanted_board", column: "post_id", name: "draw_pool_ibfk_1", on_delete: :cascade
  add_foreign_key "image_pool", "user", name: "011"
  add_foreign_key "share_log", "wanted_board", column: "post_id", name: "007"
  add_foreign_key "share_log", "wanted_board", column: "post_id", name: "share_log_ibfk_1", on_delete: :cascade
  add_foreign_key "wanted_board", "univ_category", column: "univ_id", name: "004"
  add_foreign_key "wanted_board", "user", name: "001"
  add_foreign_key "wanted_comment", "user", name: "002"
  add_foreign_key "wanted_comment", "wanted_board", name: "003"
  add_foreign_key "wanted_comment", "wanted_board", name: "wanted_comment_ibfk_1", on_delete: :cascade
  add_foreign_key "withdraw", "banks", name: "090"
  add_foreign_key "withdraw", "user", name: "008"
end
