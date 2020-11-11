# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_11_064406) do

  create_table "cards", force: :cascade do |t|
    t.string "name_en"
    t.string "name_ja"
    t.string "number"
    t.integer "num_of_pick", default: 0, null: false
    t.integer "num_of_use", default: 0, null: false
    t.integer "num_of_win", default: 0, null: false
    t.integer "sum_of_score", default: 0, null: false
    t.integer "sum_of_pick", default: 0, null: false
    t.float "win_rate", default: 0.0, null: false
    t.float "use_rate", default: 0.0, null: false
    t.float "score_ave", default: 0.0, null: false
    t.float "pick_ave", default: 0.0, null: false
    t.string "category"
  end

  create_table "picks", force: :cascade do |t|
    t.integer "pick_number"
    t.integer "card_id"
    t.integer "result_id"
    t.boolean "used", default: false, null: false
    t.index ["card_id"], name: "index_picks_on_card_id"
    t.index ["result_id"], name: "index_picks_on_result_id"
  end

  create_table "results", force: :cascade do |t|
    t.integer "player"
    t.integer "turn_number"
    t.integer "rank"
    t.integer "score"
    t.integer "user_id"
    t.index ["user_id"], name: "index_results_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "user_name"
    t.string "image_url"
  end

  add_foreign_key "picks", "cards"
  add_foreign_key "picks", "results"
end
