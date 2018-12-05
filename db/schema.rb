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

ActiveRecord::Schema.define(version: 2018_12_05_135457) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number_week", default: [], array: true
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "carts_copies", id: false, force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.bigint "copy_id", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_games", id: false, force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "category_id", null: false
    t.index ["category_id", "game_id"], name: "index_categories_games_on_category_id_and_game_id"
    t.index ["game_id", "category_id"], name: "index_categories_games_on_game_id_and_category_id"
  end

  create_table "copies", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "game_id"
    t.boolean "available"
    t.string "address"
    t.date "return"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "rented"
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
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number_week", default: [], array: true
    t.boolean "renting", default: [], array: true
    t.index ["user_id"], name: "index_orders_on_user_id"
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
