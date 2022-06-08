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

ActiveRecord::Schema.define(version: 2022_06_08_163657) do

  create_table "barmen", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "surname"
    t.index ["email"], name: "index_barmen_on_email", unique: true
    t.index ["reset_password_token"], name: "index_barmen_on_reset_password_token", unique: true
  end

  create_table "bars", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "address"
    t.string "tel"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "barman_id", null: false
    t.index ["barman_id"], name: "index_bars_on_barman_id"
  end

  create_table "chats", force: :cascade do |t|
    t.string "option"
    t.integer "bar_id", null: false
    t.integer "drinker_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bar_id"], name: "index_chats_on_bar_id"
    t.index ["drinker_id"], name: "index_chats_on_drinker_id"
  end

  create_table "cocktails", force: :cascade do |t|
    t.string "name"
    t.text "preparation"
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "bar_id", null: false
    t.string "pic"
    t.boolean "signature"
    t.string "ingredients"
    t.index ["bar_id"], name: "index_cocktails_on_bar_id"
  end

  create_table "drinkers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "chat_id"
    t.integer "roles_mask"
    t.index ["email"], name: "index_drinkers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_drinkers_on_reset_password_token", unique: true
  end

  create_table "reviews", force: :cascade do |t|
    t.string "text"
    t.integer "vote"
    t.integer "drinker_id", null: false
    t.integer "bar_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bar_id"], name: "index_reviews_on_bar_id"
    t.index ["drinker_id"], name: "index_reviews_on_drinker_id"
  end

  add_foreign_key "bars", "barmen"
  add_foreign_key "chats", "bars"
  add_foreign_key "chats", "drinkers"
  add_foreign_key "cocktails", "bars"
  add_foreign_key "reviews", "bars"
  add_foreign_key "reviews", "drinkers"
end
