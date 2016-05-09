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

ActiveRecord::Schema.define(version: 20160506090510) do

  create_table "activities", force: :cascade do |t|
    t.integer  "User_id"
    t.integer  "action_type"
    t.integer  "target_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "activities", ["User_id"], name: "index_activities_on_User_id"

  create_table "course_subjects", force: :cascade do |t|
    t.integer  "Course_id"
    t.integer  "Subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "course_subjects", ["Course_id"], name: "index_course_subjects_on_Course_id"
  add_index "course_subjects", ["Subject_id"], name: "index_course_subjects_on_Subject_id"

  create_table "courses", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "subjects", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "status"
    t.integer  "Subject_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "tasks", ["Subject_id"], name: "index_tasks_on_Subject_id"

  create_table "user_courses", force: :cascade do |t|
    t.integer  "Course_id"
    t.integer  "User_id"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_courses", ["Course_id"], name: "index_user_courses_on_Course_id"
  add_index "user_courses", ["User_id"], name: "index_user_courses_on_User_id"

  create_table "user_subjects", force: :cascade do |t|
    t.integer  "Subject_id"
    t.integer  "User_id"
    t.integer  "User_Course_id"
    t.integer  "status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "user_subjects", ["Subject_id"], name: "index_user_subjects_on_Subject_id"
  add_index "user_subjects", ["User_Course_id"], name: "index_user_subjects_on_User_Course_id"
  add_index "user_subjects", ["User_id"], name: "index_user_subjects_on_User_id"

  create_table "user_tasks", force: :cascade do |t|
    t.integer  "User_id"
    t.integer  "Task_id"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_tasks", ["Task_id"], name: "index_user_tasks_on_Task_id"
  add_index "user_tasks", ["User_id"], name: "index_user_tasks_on_User_id"

  create_table "users", force: :cascade do |t|
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
    t.integer  "role"
    t.string   "avatar"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
