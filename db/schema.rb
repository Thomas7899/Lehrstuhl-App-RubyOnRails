# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_26_213508) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "vector"

# Could not dump table "abstrakte_abschlussarbeiten" because of following StandardError
#   Unknown type 'vector(1536)' for column 'embedding'


# Could not dump table "abstrakte_seminare" because of following StandardError
#   Unknown type 'vector(1536)' for column 'embedding'


  create_table "chat_messages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "content", null: false
    t.string "role", default: "user", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role"], name: "index_chat_messages_on_role"
    t.index ["user_id", "created_at"], name: "index_chat_messages_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_chat_messages_on_user_id"
  end

# Could not dump table "klausuren" because of following StandardError
#   Unknown type 'vector(1536)' for column 'embedding'


# Could not dump table "klausurergebnisse" because of following StandardError
#   Unknown type 'vector(1536)' for column 'embedding'


# Could not dump table "konkrete_abschlussarbeiten" because of following StandardError
#   Unknown type 'vector(1536)' for column 'embedding'


  create_table "mitarbeiter", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "vorname"
    t.string "nachname"
    t.string "email", null: false
    t.string "titel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_mitarbeiter_on_email", unique: true
  end

# Could not dump table "seminare" because of following StandardError
#   Unknown type 'vector(1536)' for column 'embedding'


  create_table "seminarergebnisse", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.float "muendlich_note"
    t.float "schriftlich_note"
    t.float "gesamt"
    t.integer "versuche", default: 0
    t.bigint "student_id"
    t.uuid "seminar_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seminar_id"], name: "index_seminarergebnisse_on_seminar_id"
    t.index ["student_id", "seminar_id"], name: "index_seminarergebnisse_on_student_id_and_seminar_id", unique: true
    t.index ["student_id"], name: "index_seminarergebnisse_on_student_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "email"
    t.string "matrikelnummer"
    t.string "vorname"
    t.string "nachname"
    t.date "geburtsdatum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "abstrakte_seminare", "mitarbeiter"
  add_foreign_key "chat_messages", "students", column: "user_id"
  add_foreign_key "klausurergebnisse", "klausuren", column: "klausur_id"
  add_foreign_key "klausurergebnisse", "students"
  add_foreign_key "konkrete_abschlussarbeiten", "abstrakte_abschlussarbeiten", column: "abstrakte_abschlussarbeit_id"
  add_foreign_key "konkrete_abschlussarbeiten", "students"
  add_foreign_key "seminare", "abstrakte_seminare", column: "abstraktes_seminar_id"
  add_foreign_key "seminare", "mitarbeiter"
  add_foreign_key "seminarergebnisse", "seminare", column: "seminar_id"
  add_foreign_key "seminarergebnisse", "students"
  add_foreign_key "sessions", "users"
end
