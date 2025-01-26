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

ActiveRecord::Schema[8.0].define(version: 2025_01_24_191531) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "abstrakte_abschlussarbeits", force: :cascade do |t|
    t.string "betreuer"
    t.string "forschungsprojekt"
    t.string "semester"
    t.string "thema"
    t.string "themenskizze"
    t.integer "projekt_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "konkrete_abschlussarbeits", force: :cascade do |t|
    t.string "betreuer"
    t.string "forschungsprojekt"
    t.string "semester"
    t.string "matrikelnummer"
    t.string "angepasste_themenskizze"
    t.string "gesetzte_schwerpunkte"
    t.date "anmeldung_pruefungsamt"
    t.date "abgabedatum"
    t.integer "studienniveau"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "projekt_id"
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

  add_foreign_key "sessions", "users"
end
