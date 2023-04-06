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

ActiveRecord::Schema[7.0].define(version: 2023_04_06_082617) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cooking_steps", id: false, force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.integer "step", null: false
    t.string "description", limit: 1000, null: false
    t.string "pic_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_cooking_steps_on_recipe_id"
  end

  create_table "follows", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "followed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_follows_on_followed_id"
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name", null: false
    t.string "pic_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "metrics", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "abbrev", limit: 6, null: false
    t.float "volume"
    t.float "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", id: false, force: :cascade do |t|
    t.string "id", null: false
    t.bigint "user_id", null: false
    t.string "shipping_address", null: false
    t.float "shipping_fee", null: false
    t.float "payment_fee", null: false
    t.float "order_total", null: false
    t.float "total", null: false
    t.string "status", null: false
    t.datetime "order_time", precision: nil, null: false
    t.datetime "paid_time", precision: nil
    t.datetime "sent_time", precision: nil
    t.datetime "finished_time", precision: nil
    t.datetime "cancel_time", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "recipe_bundles", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.string "description", null: false
    t.string "title", null: false
    t.float "price", null: false
    t.integer "stock", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_recipe_bundles_on_recipe_id"
  end

  create_table "recipe_comments", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "recipe_id", null: false
    t.string "content", limit: 3000, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_recipe_comments_on_recipe_id"
    t.index ["user_id"], name: "index_recipe_comments_on_user_id"
  end

  create_table "recipe_ingredients", id: false, force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "ingredient_id", null: false
    t.integer "quantity"
    t.bigint "metric_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id"
    t.index ["metric_id"], name: "index_recipe_ingredients_on_metric_id"
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"
  end

  create_table "recipe_saved_by_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "recipe_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_recipe_saved_by_users_on_recipe_id"
    t.index ["user_id", "recipe_id"], name: "index_recipe_saved_by_users_on_user_id_and_recipe_id", unique: true
    t.index ["user_id"], name: "index_recipe_saved_by_users_on_user_id"
  end

  create_table "recipe_tags", id: false, force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id", "tag_id"], name: "index_recipe_tags_on_recipe_id_and_tag_id", unique: true
    t.index ["recipe_id"], name: "index_recipe_tags_on_recipe_id"
    t.index ["tag_id"], name: "index_recipe_tags_on_tag_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title", limit: 100, null: false
    t.string "poster_pic_url"
    t.string "description", limit: 1000, null: false
    t.integer "favorite_count", default: 0
    t.integer "prep_time"
    t.integer "serving"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "profile_pic_url"
    t.integer "followers_count", default: 0
    t.integer "following_count", default: 0
    t.integer "bookmark_count", default: 0
    t.integer "posted_recipe_count", default: 0
  end

  add_foreign_key "cooking_steps", "recipes"
  add_foreign_key "follows", "users"
  add_foreign_key "follows", "users", column: "followed_id"
  add_foreign_key "orders", "users"
  add_foreign_key "recipe_bundles", "recipes"
  add_foreign_key "recipe_comments", "recipes"
  add_foreign_key "recipe_comments", "users"
  add_foreign_key "recipe_ingredients", "ingredients"
  add_foreign_key "recipe_ingredients", "metrics"
  add_foreign_key "recipe_ingredients", "recipes"
  add_foreign_key "recipe_saved_by_users", "recipes"
  add_foreign_key "recipe_saved_by_users", "users"
  add_foreign_key "recipe_tags", "recipes"
  add_foreign_key "recipe_tags", "tags"
  add_foreign_key "recipes", "users"
end
