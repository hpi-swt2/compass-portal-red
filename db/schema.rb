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

ActiveRecord::Schema.define(version: 2021_12_09_160350) do

  create_table "buildings", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "data_problems", force: :cascade do |t|
    t.string "url"
    t.string "description"
    t.string "field"
    t.integer "rooms_id"
    t.integer "people_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["people_id"], name: "index_data_problems_on_people_id"
    t.index ["rooms_id"], name: "index_data_problems_on_rooms_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "title"
    t.string "email"
    t.string "phone"
    t.string "office"
    t.string "website"
    t.string "image"
    t.string "chair"
    t.string "office_hours"
    t.string "telegram_handle"
    t.string "knowledge"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "human_verified_name"
    t.datetime "human_verified_surname"
    t.datetime "human_verified_title"
    t.datetime "human_verified_email"
    t.datetime "human_verified_phone"
    t.datetime "human_verified_office"
    t.datetime "human_verified_website"
    t.datetime "human_verified_image"
    t.datetime "human_verified_chair"
    t.datetime "human_verified_office_hours"
    t.datetime "human_verified_telegram_handle"
    t.datetime "human_verified_knowledge"
  end

  create_table "person_urls", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "point_of_interests", force: :cascade do |t|
    t.integer "point_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["point_id"], name: "index_point_of_interests_on_point_id"
  end

  create_table "point_of_interests_rooms", id: false, force: :cascade do |t|
    t.integer "room_id", null: false
    t.integer "point_of_interest_id", null: false
  end

  create_table "points", force: :cascade do |t|
    t.float "x"
    t.float "y"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "points_polylines", id: false, force: :cascade do |t|
    t.integer "point_id", null: false
    t.integer "polyline_id", null: false
  end

  create_table "polylines", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "outer_shape_id", null: false
    t.integer "building_id"
    t.index ["building_id"], name: "index_rooms_on_building_id"
    t.index ["outer_shape_id"], name: "index_rooms_on_outer_shape_id"
  end

  create_table "rooms_walls", id: false, force: :cascade do |t|
    t.integer "room_id", null: false
    t.integer "wall_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "walls", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "polyline_id", null: false
    t.index ["polyline_id"], name: "index_walls_on_polyline_id"
  end

  add_foreign_key "data_problems", "people", column: "people_id"
  add_foreign_key "data_problems", "rooms", column: "rooms_id"
  add_foreign_key "point_of_interests", "points"
  add_foreign_key "rooms", "buildings"
  add_foreign_key "rooms", "polylines", column: "outer_shape_id"
  add_foreign_key "walls", "polylines"
end
