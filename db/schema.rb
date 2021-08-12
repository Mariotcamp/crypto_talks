# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_12_052402) do

  create_table "end_users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest", null: false
    t.string "remember_digest"
    t.integer "quiz_score"
    t.index ["email"], name: "index_end_users_on_email", unique: true
    t.index ["name"], name: "index_end_users_on_name", unique: true
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "question", null: false
    t.string "option1", null: false
    t.string "option2", null: false
    t.string "option3", null: false
    t.string "option4", null: false
    t.integer "answer_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
