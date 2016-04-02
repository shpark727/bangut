class CreateSchema < ActiveRecord::Migration
  
    def self.up
        
  create_table "app_version", primary_key: "version_code", force: :cascade do |t|
    t.string   "version_name", limit: 64
    t.boolean  "force_update"
		t.timestamps null: false
  end

  create_table "banks", force: :cascade do |t|
    t.string  "bank_name", limit: 45
    t.integer "bank_code", limit: 4
  end
  
  create_table "token", force: :cascade do |t|
    t.string "utoken",  limit: 255
		t.integer "user_id", limit: 255
  end

  create_table "facebook_user", force: :cascade do |t|
    t.integer  "provider",         limit: 255
    t.integer  "uid",              limit: 255
    t.string   "name",             limit: 255
		t.string	 "email", 					 limit: 255
    t.integer  "oauth_token",      limit: 255
    t.datetime "oauth_expires_at"
  end

  create_table "faq", force: :cascade do |t|
    t.string   "email",        limit: 255
    t.string   "title",        limit: 255
    t.text     "content",      limit: 4294967295
		t.timestamps null: false
  end

  create_table "image_pool", force: :cascade do |t|
    t.string "path", limit: 64
		t.integer  "user_id", limit: 4
  end
	 add_index "image_pool", ["user_id"], name: "011_idx", using: :btree

	create_table "draw_pool", force: :cascade do |t|
		t.string "path", limit: 64
		t.integer "post_id", limit: 4
	end
	add_index "draw_pool",["post_id"], name: "050_idx", using: :btree
	

  create_table "notice", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.text     "content",      limit: 4294967295
		t.timestamps null: false
  end

  create_table "push_configurations", force: :cascade do |t|
    t.string   "type",        limit: 255,                   null: false
    t.string   "app",         limit: 255,                   null: false
    t.text     "properties",  limit: 65535
    t.boolean  "enabled",                   default: false, null: false
    t.integer  "connections", limit: 4,     default: 1,     null: false
		t.timestamps null: false
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
		t.timestamps null: false
  end

  add_index "push_feedback", ["processed"], name: "index_push_feedback_on_processed", using: :btree

	create_table "push_onoff", force: :cascade do |t|
		t.boolean  "onoff",														default: false, null: false

	end


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
		t.timestamps null: false
  end

  add_index "push_messages", ["delivered", "failed", "deliver_after"], name: "index_push_messages_on_delivered_and_failed_and_deliver_after", using: :btree

  create_table "share_log", force: :cascade do |t|
    t.integer  "post_id",      limit: 4, null: false
    t.string   "share_type",   limit: 8, null: false
		t.timestamps null: false
  end

  add_index "share_log", ["post_id"], name: "007_idx", using: :btree

  create_table "term", force: :cascade do |t|
		t.string "term_code", limit: 8
    t.text "term_content", limit: 4294967295
		t.timestamps
  end

  create_table "univ_category", force: :cascade do |t|
    t.string "univ_name", limit: 45
  end

  create_table "user", force: :cascade do |t|
    t.string   "email",          limit: 255
    t.string   "password",       limit: 255
    t.string   "name",           limit: 64,  null: false
    t.string   "facebook_token", limit: 255
    t.integer  "profile_img",    limit: 4
		t.string  "user_token", 			limit: 255
		t.timestamps null: false
  end

  #add_index "user", ["profile_img"], name: "009_idx", using: :btree

  create_table "wanted_board", force: :cascade do |t|
    t.integer  "univ_id",        limit: 4
    t.datetime "witness_date"
    t.boolean  "is_place_maps"
    t.string   "witness_place",  limit: 255
    t.string   "target_body",    limit: 3
    t.integer  "target_tall",    limit: 4
    t.string   "target_hair",    limit: 3
    t.string   "target_initial", limit: 16
    t.string   "target_gen",     limit: 1
    t.text     "talk_to",        limit: 16777215
    t.integer  "reward",         limit: 4
    t.integer  "user_id",        limit: 4
    t.integer  "count_share",    limit: 4,        default: 0
		t.string  "draw_img", 			 limit: 255
    t.integer  "choosed_id",     limit: 4
		t.timestamps null: false
  end

  add_index "wanted_board", ["univ_id"], name: "004_idx", using: :btree
  add_index "wanted_board", ["user_id"], name: "001_idx", using: :btree

  create_table "wanted_comment", force: :cascade do |t|
    t.integer  "wanted_board_id",      limit: 4
    t.integer  "user_id",      limit: 4
    t.text     "content",      limit: 65535
		t.timestamps null: false
  end

  add_index "wanted_comment", ["wanted_board_id"], name: "003_idx", using: :btree
  add_index "wanted_comment", ["user_id"], name: "002_idx", using: :btree

  create_table "withdraw", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "bank_id",      limit: 4
    t.integer  "sum",          limit: 4
    t.string   "bank_account", limit: 64
		t.timestamps null: false
  end

  add_index "withdraw", ["bank_id"], name: "009_idx", using: :btree
  add_index "withdraw", ["user_id"], name: "008_idx", using: :btree

  add_foreign_key "share_log", "wanted_board", column: "post_id", name: "007"
	add_foreign_key "image_pool", "user", column: "user_id", name: "011"
	add_foreign_key "draw_pool", "wanted_board", column: "post_id", name: "050"

  #add_foreign_key "user", "image_pool", column: "profile_img", name: "009"
  add_foreign_key "wanted_board", "univ_category", column: "univ_id", name: "004"
  add_foreign_key "wanted_board", "user", name: "001"
  add_foreign_key "wanted_comment", "user", name: "002"
  add_foreign_key "wanted_comment", "wanted_board", column: "wanted_board_id", name: "003"
  add_foreign_key "withdraw", "banks", name: "010"
  add_foreign_key "withdraw", "user", name: "008"    
        
    end
    
    def self.down
    end
    
end
