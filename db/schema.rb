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

ActiveRecord::Schema.define(version: 2020_05_10_050210) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "branches", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_branches_on_user_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name", null: false
    t.integer "employment_status", null: false
    t.date "hire_date", null: false
    t.bigint "branch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_employees_on_branch_id"
    t.index ["hire_date"], name: "index_employees_on_hire_date"
    t.index ["name"], name: "index_employees_on_name"
  end

  create_table "holidays", force: :cascade do |t|
    t.integer "add_day"
    t.integer "delete_day"
    t.string "reason", default: "法定付与日のため", null: false
    t.bigint "user_id"
    t.bigint "employees_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["add_day"], name: "index_holidays_on_add_day"
    t.index ["delete_day"], name: "index_holidays_on_delete_day"
    t.index ["employees_id"], name: "index_holidays_on_employees_id"
    t.index ["user_id"], name: "index_holidays_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "branches", "users"
  add_foreign_key "employees", "branches"
  add_foreign_key "holidays", "employees", column: "employees_id"
  add_foreign_key "holidays", "users"
end
