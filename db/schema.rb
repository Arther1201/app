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

ActiveRecord::Schema[7.0].define(version: 2024_10_03_064912) do
  create_table "chat_rooms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_chat_rooms_on_department_id"
  end

  create_table "departments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "message_id", null: false
    t.index ["message_id"], name: "index_favorites_on_message_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "messages", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "chat_room_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_room_id"], name: "index_messages_on_chat_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "models", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "impression_date"
    t.string "medical_record_number"
    t.string "patient_name"
    t.string "storage_location"
  end

  create_table "orders", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "supply_id", null: false
    t.date "order_date"
    t.date "delivery_date"
    t.integer "order_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supply_id"], name: "index_orders_on_supply_id"
  end

  create_table "patient_archives", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "medical_record_number"
    t.date "impression_date"
    t.string "prosthesis_type_insurance"
    t.string "prosthesis_type_crown"
    t.string "prosthesis_type_denture"
    t.string "upper_left"
    t.string "upper_right"
    t.string "lower_left"
    t.string "lower_right"
    t.decimal "metal_amount", precision: 10
    t.string "requester"
    t.string "trial_or_set"
    t.date "set_date"
    t.boolean "note_checked"
    t.boolean "delivery_checked"
    t.integer "archived_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "patient_id"
  end

  create_table "patients", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "impression_date"
    t.boolean "note_checked"
    t.string "medical_record_number"
    t.string "name"
    t.string "gender"
    t.string "prosthesis_type"
    t.string "prosthesis_site"
    t.string "metal_type"
    t.decimal "metal_amount", precision: 10
    t.string "trial_or_set"
    t.date "set_date"
    t.boolean "delivery_checked"
    t.text "memo"
    t.string "medicine_notebook"
    t.text "images"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "requester"
    t.text "prosthesis_sites"
    t.text "upper_right"
    t.text "upper_left"
    t.text "lower_right"
    t.text "lower_left"
    t.string "prosthesis_type_insurance"
    t.string "prosthesis_type_crown"
    t.string "prosthesis_type_denture"
  end

  create_table "prostheses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "group"
  end

  create_table "supplies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "category"
    t.string "item_name"
    t.date "order_date"
    t.integer "order_quantity"
    t.date "delivery_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "manufacturer"
    t.decimal "price", precision: 10
    t.integer "stock_quantity"
    t.boolean "delivered"
    t.integer "department_id"
  end

  create_table "supply_archives", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "year"
    t.text "archived_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "department_id"
    t.index ["department_id"], name: "index_users_on_department_id"
  end

  add_foreign_key "chat_rooms", "departments"
  add_foreign_key "messages", "chat_rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "orders", "supplies"
end
