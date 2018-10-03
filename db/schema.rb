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

ActiveRecord::Schema.define(version: 2018_09_25_112019) do

  create_table "class_students", force: :cascade do |t|
    t.integer "user_id"
    t.integer "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_class_students_on_subject_id"
    t.index ["user_id"], name: "index_class_students_on_user_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string "message"
    t.string "reply"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_feedbacks_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "schedule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_invitations_on_schedule_id"
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "oversees", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_oversees_on_code"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.integer "volume"
    t.boolean "state"
    t.integer "overseer_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.string "code_subject"
    t.string "name_subject"
    t.integer "times_exam"
    t.string "room_code"
    t.string "room_name"
    t.string "day"
    t.integer "session"
    t.integer "group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "email"
    t.string "info"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.integer "times_exam"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "email"
    t.string "info"
    t.string "password_digest"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
