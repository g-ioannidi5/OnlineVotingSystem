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

ActiveRecord::Schema.define(version: 20150609174357) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_codes", force: :cascade do |t|
    t.string   "code"
    t.date     "valid_until"
    t.integer  "lecturer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "subject_id"
  end

  add_index "access_codes", ["lecturer_id"], name: "index_access_codes_on_lecturer_id", using: :btree
  add_index "access_codes", ["subject_id"], name: "index_access_codes_on_subject_id", using: :btree

  create_table "histories", force: :cascade do |t|
    t.string   "answer"
    t.integer  "student"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "poll_id"
    t.integer  "question_id"
  end

  add_index "histories", ["poll_id"], name: "index_histories_on_poll_id", using: :btree
  add_index "histories", ["question_id"], name: "index_histories_on_question_id", using: :btree

  create_table "lecturers", force: :cascade do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lecturers", ["email"], name: "index_lecturers_on_email", unique: true, using: :btree
  add_index "lecturers", ["reset_password_token"], name: "index_lecturers_on_reset_password_token", unique: true, using: :btree

  create_table "poll_histories", force: :cascade do |t|
    t.integer  "poll_id"
    t.integer  "question_id"
    t.string   "answer"
    t.integer  "student"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "polls", force: :cascade do |t|
    t.string   "name"
    t.integer  "lecturer_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.date     "poll_date"
    t.string   "access_code"
    t.integer  "access_code_lecturer"
    t.integer  "subject_id"
  end

  add_index "polls", ["lecturer_id"], name: "index_polls_on_lecturer_id", using: :btree
  add_index "polls", ["subject_id"], name: "index_polls_on_subject_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.text     "question"
    t.string   "answer1"
    t.string   "answer2"
    t.string   "answer3"
    t.string   "answer4"
    t.string   "answer5"
    t.string   "answer6"
    t.integer  "poll_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "response1"
    t.integer  "response2"
    t.integer  "response3"
    t.integer  "response4"
    t.integer  "response5"
    t.integer  "response6"
    t.integer  "total_responses"
    t.integer  "status"
    t.integer  "downloadable"
    t.integer  "lecturer_id"
    t.string   "access_code"
    t.string   "chart_style"
  end

  add_index "questions", ["lecturer_id"], name: "index_questions_on_lecturer_id", using: :btree
  add_index "questions", ["poll_id"], name: "index_questions_on_poll_id", using: :btree

  create_table "students", force: :cascade do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_question"
  end

  add_index "students", ["email"], name: "index_students_on_email", unique: true, using: :btree
  add_index "students", ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true, using: :btree

  create_table "subjects", force: :cascade do |t|
    t.string   "code"
    t.string   "title"
    t.integer  "lecturer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "subjects", ["lecturer_id"], name: "index_subjects_on_lecturer_id", using: :btree

  create_table "whitelists", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
