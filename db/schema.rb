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

ActiveRecord::Schema.define(version: 2022_02_09_135614) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "buildings", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", null: false
  end

  create_table "chairs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image", default: "placeholder_chair.png"
  end

  create_table "chairs_people", id: false, force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "chair_id", null: false
  end

  create_table "chairs_rooms", id: false, force: :cascade do |t|
    t.integer "room_id", null: false
    t.integer "chair_id", null: false
  end

  create_table "course_times", force: :cascade do |t|
    t.string "weekday"
    t.string "start_time"
    t.string "end_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "course_id"
    t.index ["course_id"], name: "index_course_times_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "module_category"
    t.datetime "exam_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "room_id"
    t.string "image", default: "placeholder_course.png"
    t.index ["room_id"], name: "index_courses_on_room_id"
  end

  create_table "courses_people", id: false, force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "course_id", null: false
  end

  create_table "data_problems", force: :cascade do |t|
    t.string "url"
    t.string "description"
    t.string "field"
    t.integer "room_id"
    t.integer "person_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_data_problems_on_person_id"
    t.index ["room_id"], name: "index_data_problems_on_room_id"
  end

  create_table "email_logs", force: :cascade do |t|
    t.text "email_address"
    t.date "last_sent"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "people_id"
  end

  create_table "floors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "building_id", null: false
    t.index ["building_id"], name: "index_floors_on_building_id"
  end

  create_table "information", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "person_id"
    t.datetime "human_verified"
    t.index ["person_id"], name: "index_information_on_person_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "email"
    t.string "last_name"
    t.string "first_name"
    t.string "title"
    t.string "image", default: "placeholder_person.png"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "room_id"
    t.integer "user_id"
    t.datetime "human_verified_email"
    t.datetime "human_verified_last_name"
    t.datetime "human_verified_first_name"
    t.datetime "human_verified_title"
    t.datetime "human_verified_image"
    t.datetime "human_verified_room_id"
    t.datetime "human_verified_status"
    t.index ["user_id"], name: "index_people_on_user_id"
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
    t.string "description"
    t.string "name"
    t.string "image", default: "placeholder_poi.png"
    t.index ["point_id"], name: "index_point_of_interests_on_point_id"
  end

  create_table "points", force: :cascade do |t|
    t.float "x"
    t.float "y"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "osm_node_id"
    t.integer "room_id"
    t.index ["room_id"], name: "index_points_on_room_id"
  end

  create_table "points_polylines", id: false, force: :cascade do |t|
    t.integer "point_id", null: false
    t.integer "polyline_id", null: false
  end

  create_table "points_rooms", id: false, force: :cascade do |t|
    t.integer "point_id", null: false
    t.integer "room_id", null: false
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
    t.string "number"
    t.string "full_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "outer_shape_id", null: false
    t.string "image", default: "placeholder_room.png"
    t.integer "floor_id", null: false
    t.index ["floor_id"], name: "index_rooms_on_floor_id"
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
    t.boolean "isAdmin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "walls", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "polyline_id", null: false
    t.index ["polyline_id"], name: "index_walls_on_polyline_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "data_problems", "people"
  add_foreign_key "data_problems", "rooms"
  add_foreign_key "floors", "buildings"
  add_foreign_key "point_of_interests", "points"
  add_foreign_key "points", "rooms"
  add_foreign_key "rooms", "floors"
  add_foreign_key "rooms", "polylines", column: "outer_shape_id"
  add_foreign_key "walls", "polylines"
end
