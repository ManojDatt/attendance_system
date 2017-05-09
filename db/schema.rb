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

ActiveRecord::Schema.define(version: 20170413092138) do

  create_table "active_admin_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "namespace"
    t.text     "body",          limit: 65535
    t.string   "resource_id",                 null: false
    t.string   "resource_type",               null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role"
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "apply_leaves", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float    "total_leave",  limit: 24
    t.date     "start_date"
    t.date     "end_date"
    t.text     "reason",       limit: 65535
    t.integer  "status"
    t.integer  "developer_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "leave_type"
    t.index ["developer_id"], name: "index_apply_leaves_on_developer_id", using: :btree
  end

  create_table "attendances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "developer_id"
    t.datetime "punch_in_time"
    t.datetime "punch_out_time"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "extra_work"
    t.string   "work_hour"
    t.datetime "lat_in"
    t.string   "early_out"
    t.boolean  "punch_out_status",            default: false
    t.boolean  "week_off",                    default: false
    t.float    "punch_in_at",      limit: 24, default: 10.0
    t.float    "punch_out_at",     limit: 24, default: 19.0
    t.boolean  "is_hollyday",                 default: false
    t.boolean  "punch_in_status",             default: false
    t.boolean  "first_half"
    t.boolean  "second_half"
    t.index ["developer_id"], name: "index_attendances_on_developer_id", using: :btree
  end

  create_table "developers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.string   "domain"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "sign_in_mac"
    t.boolean  "is_locked",              default: false
    t.index ["email"], name: "index_developers_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_developers_on_reset_password_token", unique: true, using: :btree
  end

  create_table "dsr_replies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "todo_id"
    t.text     "message",    limit: 65535
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "seen",                     default: false
    t.index ["todo_id"], name: "index_dsr_replies_on_todo_id", using: :btree
  end

  create_table "leaves", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float    "total_leave",     limit: 24
    t.float    "available_leave", limit: 24
    t.integer  "developer_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["developer_id"], name: "index_leaves_on_developer_id", using: :btree
  end

  create_table "notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "message"
    t.boolean  "unseen",            default: true
    t.string   "notification_type"
    t.integer  "developer_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["developer_id"], name: "index_notifications_on_developer_id", using: :btree
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "domain"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "todos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "task_name"
    t.string   "task_time"
    t.string   "task_type"
    t.string   "remark"
    t.integer  "project_id"
    t.integer  "developer_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["developer_id"], name: "index_todos_on_developer_id", using: :btree
    t.index ["project_id"], name: "index_todos_on_project_id", using: :btree
  end

  add_foreign_key "apply_leaves", "developers"
  add_foreign_key "attendances", "developers"
  add_foreign_key "dsr_replies", "todos"
  add_foreign_key "leaves", "developers"
  add_foreign_key "notifications", "developers"
  add_foreign_key "todos", "developers"
  add_foreign_key "todos", "projects"
end
