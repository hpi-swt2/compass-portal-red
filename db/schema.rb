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

ActiveRecord::Schema.define(version: 2021_12_02_144305) do

  create_table "buildings", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "chairs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "chairs_people", id: false, force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "chair_id", null: false
  end

  create_table "chairs_rooms", id: false, force: :cascade do |t|
    t.integer "room_id", null: false
    t.integer "chair_id", null: false
  end

  create_table "information", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "person_id"
    t.index ["person_id"], name: "index_information_on_person_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "email"
    t.string "last_name"
    t.string "first_name"
    t.string "title"
    t.string "image"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "room_id"
    t.integer "user_id"
    t.index ["user_id"], name: "index_people_on_user_id"
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

  create_table "room_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "room_types_rooms", id: false, force: :cascade do |t|
    t.integer "room_id", null: false
    t.integer "room_type_id", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "house"
    t.string "number"
    t.string "floor"
    t.string "full_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "outer_shape_id", null: false
    t.integer "building_id"
    t.index ["building_id"], name: "index_rooms_on_building_id"
    t.index ["outer_shape_id"], name: "index_rooms_on_outer_shape_id"
  end

  create_table "rooms_tags", id: false, force: :cascade do |t|
    t.integer "room_id", null: false
    t.integer "tag_id", null: false
  end

  create_table "rooms_walls", id: false, force: :cascade do |t|
    t.integer "room_id", null: false
    t.integer "wall_id", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  add_foreign_key "point_of_interests", "points"
  add_foreign_key "rooms", "buildings"
  add_foreign_key "rooms", "polylines", column: "outer_shape_id"
  add_foreign_key "walls", "polylines"
end
