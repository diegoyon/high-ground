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

ActiveRecord::Schema[7.0].define(version: 2023_09_27_204139) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"

  create_table "athletes", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "tshirt_size"
    t.string "tshirt_name"
    t.string "box"
    t.string "division"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rank"
    t.integer "total_points", default: 0
  end

  create_table "fri_athletes", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "fri_username"
    t.string "tshirt_size"
    t.string "box"
    t.string "division"
    t.string "payment_status"
    t.integer "transaction_id"
    t.jsonb "fri_request_payment_response"
    t.jsonb "fri_transaction_status_response"
    t.jsonb "fri_webhook_response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tshirt_name"
  end

  create_table "fri_checkouts", force: :cascade do |t|
    t.string "fri_username"
    t.integer "transaction_id"
    t.jsonb "fri_request_payment_response"
    t.jsonb "fri_webhook_response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string "payment_status"
    t.string "paymentable_type", null: false
    t.bigint "paymentable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "athlete_id", null: false
    t.index ["athlete_id"], name: "index_payments_on_athlete_id"
    t.index ["paymentable_type", "paymentable_id"], name: "index_payments_on_paymentable"
  end

  create_table "recurrente_athletes", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "tshirt_size"
    t.string "box"
    t.string "division"
    t.string "payment_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "checkout_id"
  end

  create_table "recurrente_checkouts", force: :cascade do |t|
    t.string "checkout_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scores", force: :cascade do |t|
    t.bigint "athlete_id", null: false
    t.bigint "workout_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "points"
    t.integer "rank"
    t.integer "main_score"
    t.integer "tiebreak_score"
    t.index ["athlete_id"], name: "index_scores_on_athlete_id"
    t.index ["workout_id"], name: "index_scores_on_workout_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "workout_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tiebreak_type"
    t.integer "workout_number"
    t.integer "time_cap"
  end

  add_foreign_key "payments", "athletes"
  add_foreign_key "scores", "athletes"
  add_foreign_key "scores", "workouts"
end
