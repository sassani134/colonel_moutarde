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

ActiveRecord::Schema.define(version: 2018_12_06_190252) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_postgresql_files", force: :cascade do |t|
    t.oid "oid"
    t.string "key"
    t.index ["key"], name: "index_active_storage_postgresql_files_on_key", unique: true
  end

  create_table "ages", force: :cascade do |t|
    t.integer "minimum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "number_week", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "carts_copies", id: false, force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.bigint "copy_id", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "player_number_id"
    t.bigint "style_id"
    t.bigint "genre_id"
    t.bigint "age_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
<<<<<<< HEAD
<<<<<<< HEAD
    t.string "age"
    t.string "style"
  end

  create_table "categories_games", id: false, force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "category_id", null: false
    t.index ["category_id", "game_id"], name: "index_categories_games_on_category_id_and_game_id"
    t.index ["game_id", "category_id"], name: "index_categories_games_on_game_id_and_category_id"
=======
=======
>>>>>>> map
    t.index ["age_id"], name: "index_categories_on_age_id"
    t.index ["game_id"], name: "index_categories_on_game_id"
    t.index ["genre_id"], name: "index_categories_on_genre_id"
    t.index ["player_number_id"], name: "index_categories_on_player_number_id"
    t.index ["style_id"], name: "index_categories_on_style_id"
<<<<<<< HEAD
>>>>>>> 50d92d8dbf41d7d7558a4e7fb02ed99cfa636c83
=======
>>>>>>> map
  end

  create_table "copies", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "game_id"
    t.boolean "available"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.boolean "rented"
    t.date "return"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_copies_on_game_id"
    t.index ["user_id"], name: "index_copies_on_user_id"
  end

  create_table "copies_orders", id: false, force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "copy_id", null: false
  end

  create_table "games", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "number_week", default: [], array: true
    t.boolean "renting", default: [], array: true
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "player_numbers", force: :cascade do |t|
    t.integer "number_low"
    t.integer "number_high"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "styles", force: :cascade do |t|
    t.string "sort"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "username"
    t.string "address"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
